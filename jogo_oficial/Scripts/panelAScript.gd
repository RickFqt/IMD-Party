extends Panel

var answer : int
var perguntas = []
var respostaCorretaAtual : int

@onready var LabelQuestion = $Question_p1 #Obtenha o caminho para a questão
@onready var LabelScore = $ScoreLabel_p1 #Obtenha o caminho para o score
@onready var ButtonA = $ButtonA_p1 #Obtenha o caminho para o botão A
@onready var ButtonB = $ButtonB_p1 #Obtenha o caminho para o botão B
@onready var ButtonC = $ButtonC_p1 #Obtenha o caminho para o botão C
@onready var ButtonD = $ButtonD_p1 #Obtenha o caminho para o botão D
@onready var textureA = $button1_p1 #Obtenha o caminho para o botão A
@onready var textureB = $button2_p1 #Obtenha o caminho para o botão B
@onready var textureC = $button3_p1 #Obtenha o caminho para o botão C
@onready var textureD = $button4_p1 #Obtenha o caminho para o botão D

@onready var idx = 0
@onready var score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	var perguntasResource = load(Global.bd_PROB)
	
	LabelScore.text = "SCORE: " + str(score)
	Global.resultadoP1 = 0
	
	for p in perguntasResource.questoes:
		perguntas.append(p)
		print(p.pergunta)
		print(p.opcaoA)

	perguntas.shuffle()
	show_pergunta(idx)
	
	
func show_pergunta(id : int):
	var perguntaAtual = perguntas[id]
		
	LabelQuestion.text = perguntaAtual.pergunta # Atribua o texto da pergunta à propriedade 'text' da label
	ButtonA.text = perguntaAtual.opcaoA # Atribua o texto da opção A à propriedade 'text' do button
	ButtonB.text = perguntaAtual.opcaoB # Atribua o texto da opção B à propriedade 'text' do button
	ButtonC.text = perguntaAtual.opcaoC # Atribua o texto da opção C à propriedade 'text' do button
	ButtonD.text = perguntaAtual.opcaoD # Atribua o texto da opção D à propriedade 'text' do button
	respostaCorretaAtual = perguntaAtual.respostaCorreta # Atribua a alternativa correta 
	
func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("key_q"):
			answer = 1
			_onAnswerSelected()
		elif event.is_action_pressed("key_w"):
			answer = 2
			_onAnswerSelected()
		elif event.is_action_pressed("key_a"):
			answer = 3
			_onAnswerSelected()
		elif event.is_action_pressed("key_s"):
			answer = 4
			_onAnswerSelected()
				
func buttonRightAnswer(button, texture):
	button.add_theme_color_override("font_color", Color( 0, 1, 0, 1))
	texture.texture = load("res://jogo_oficial/Assets/Items/buttonRight.png")
	
func buttonWrongAnswer(button, texture):
	button.add_theme_color_override("font_color", Color( 1, 0, 0, 1))
	texture.texture = load("res://jogo_oficial/Assets/Items/buttonWrong.png")
		
func _onAnswerSelected():
	self.set_process_input(false)
	if answer == respostaCorretaAtual:
		# Resposta correta
		print("Resposta correta!")
		score = score + 1
		LabelScore.text = "SCORE: " + str(score)
		if answer == 1:
			buttonRightAnswer(ButtonA, textureA)
		elif answer == 2:
			buttonRightAnswer(ButtonB, textureB)
		elif answer == 3:
			buttonRightAnswer(ButtonC, textureC)
		elif answer == 4:
			buttonRightAnswer(ButtonD, textureD)
	
	
	else:
		# Resposta incorreta
		print("Resposta incorreta!")
		if answer == 1:
			buttonWrongAnswer(ButtonA, textureA)
		elif answer == 2:
			buttonWrongAnswer(ButtonB, textureB)
		elif answer == 3:
			buttonWrongAnswer(ButtonC, textureC)
		elif answer == 4:
			buttonWrongAnswer(ButtonD, textureD)
	
	await get_tree().create_timer(2.0).timeout
	next_Question()
	
func resetButtons():
	ButtonA.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	ButtonB.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	ButtonC.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	ButtonD.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	textureA.texture = load("res://jogo_oficial/Assets/Items/button.png")
	textureB.texture = load("res://jogo_oficial/Assets/Items/button.png")
	textureC.texture = load("res://jogo_oficial/Assets/Items/button.png")
	textureD.texture = load("res://jogo_oficial/Assets/Items/button.png")
	
func next_Question():
	self.set_process_input(true)
	resetButtons()
	idx += 1
	Global.resultadoP1 = score
	if idx < perguntas.size():
		show_pergunta(idx)
	else: 
		print("Acabaram as perguntas")
		print("Pontuação final: ", score)
		



