extends Panel
 
#Variables 
var answer : int
var perguntas = []
var buttonsDisabled : bool
var respostaCorretaAtual : int

# @onready variables
@onready var idx = 0
@onready var scoreP1 = 0
@onready var ButtonAP1 = $ButtonA_P1 #Obtenha o caminho para o botão A
@onready var ButtonBP1 = $ButtonB_P1 #Obtenha o caminho para o botão B
@onready var ButtonCP1 = $ButtonC_P1 #Obtenha o caminho para o botão C
@onready var ButtonDP1 = $ButtonD_P1 #Obtenha o caminho para o botão D
@onready var LabelScoreP1 = $ScoreLabel_P1 #Obtenha o caminho para o score
@onready var LabelQuestionP1 = $Question_P1 #Obtenha o caminho para a questão

# Called when the node enters the scene tree for the first time.
func _ready():
	ButtonAP1.pressed.connect(_onAnswerSelected, 1)
	ButtonBP1.pressed.connect(_onAnswerSelected, 2)
	ButtonCP1.pressed.connect(_onAnswerSelected, 3)
	ButtonDP1.pressed.connect(_onAnswerSelected, 4)
	
	LabelQuestionP1.text = ""
	ButtonAP1.text = ""
	ButtonBP1.text = ""
	ButtonCP1.text = ""
	ButtonDP1.text = ""

	var perguntasResource = load("res://jogo_oficial/Resource/bd_questions.tres")
	
	LabelScoreP1.text = "SCORE: " + str(scoreP1)
	
	for p in perguntasResource.perguntas:
		perguntas.append(p)
		print(p.pergunta)
		print(p.opcaoA)

	perguntas.shuffle()

# Função para começar a mostra as questões
func _onCountdownFinished():
	show_pergunta(idx)
	
# Função para mostrar a questão
func show_pergunta(id : int):
	var perguntaAtual = perguntas[id]
		
	LabelQuestionP1.text = perguntaAtual.pergunta # Atribua o texto da pergunta à propriedade 'text' da label
	ButtonAP1.text = perguntaAtual.opcaoA # Atribua o texto da opção A à propriedade 'text' do button
	ButtonBP1.text = perguntaAtual.opcaoB # Atribua o texto da opção B à propriedade 'text' do button
	ButtonCP1.text = perguntaAtual.opcaoC # Atribua o texto da opção C à propriedade 'text' do button
	ButtonDP1.text = perguntaAtual.opcaoD # Atribua o texto da opção D à propriedade 'text' do button
	respostaCorretaAtual = perguntaAtual.respostaCorreta # Atribua a alternativa correta 
	buttonsDisabled = false
	
	
# Função para captar a resposta do player
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.as_text_keycode() == "A":
				answer = 1
				ButtonAP1.emit_signal("pressed")
			elif event.as_text_keycode() == "S":
				answer = 2
				ButtonBP1.emit_signal("pressed")
			elif event.as_text_keycode() == "D":
				answer = 3
				ButtonCP1.emit_signal("pressed")
			elif event.as_text_keycode() == "F":
				answer = 4
				ButtonDP1.emit_signal("pressed")
				
# Função para corrigir a resposta do player
func _onAnswerSelected():
	if buttonsDisabled:
		return
	buttonsDisabled = true
	
	if answer == respostaCorretaAtual:
		# Resposta correta
		print("Resposta correta!")
		scoreP1 = scoreP1 + 1
		LabelScoreP1.text = "SCORE: " + str(scoreP1)
		if answer == 1:
			ButtonAP1.add_theme_color_override("font_color", Color( 0, 1, 0, 1))
		elif answer == 2:
			ButtonBP1.add_theme_color_override("font_color", Color( 0, 1, 0, 1))
		elif answer == 3:
			ButtonCP1.add_theme_color_override("font_color", Color( 0, 1, 0, 1))
		elif answer == 4:
			ButtonDP1.add_theme_color_override("font_color", Color( 0, 1, 0, 1))
	
	
	else:
		# Resposta incorreta
		print("Resposta incorreta!")
		if answer == 1:
			ButtonAP1.add_theme_color_override("font_color", Color( 1, 0, 0, 1))
		elif answer == 2:
			ButtonBP1.add_theme_color_override("font_color", Color( 1, 0, 0, 1))
		elif answer == 3:
			ButtonCP1.add_theme_color_override("font_color", Color( 1, 0, 0, 1))
		elif answer == 4:
			ButtonDP1.add_theme_color_override("font_color", Color( 1, 0, 0, 1))
	
	await get_tree().create_timer(2.0).timeout
	next_Question()
	

#Função para mostrar a pergunta seguinte
func next_Question():
	ButtonAP1.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	ButtonBP1.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	ButtonCP1.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	ButtonDP1.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	
	idx = idx + 1
	if idx < perguntas.size():
		show_pergunta(idx)
	else: 
		print("Acabaram as perguntas")
		print("Pontuação final: ", scoreP1)
	
# Função para finalizar o jogo
func end_Game():
	print("Fim de jogo!")


