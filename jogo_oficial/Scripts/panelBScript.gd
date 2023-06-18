extends Panel

#Variables 
var answer : int
var perguntas = []
var buttonsDisabled : bool
var respostaCorretaAtual : int

# @onready variables
@onready var idx = 0
@onready var scoreP2 = 0
@onready var ButtonAP2 = $ButtonA_P2 #Obtenha o caminho para o botão A
@onready var ButtonBP2 = $ButtonB_P2 #Obtenha o caminho para o botão B
@onready var ButtonCP2 = $ButtonC_P2 #Obtenha o caminho para o botão C
@onready var ButtonDP2 = $ButtonD_P2 #Obtenha o caminho para o botão D
@onready var LabelScoreP2 = $ScoreLabel_P2 #Obtenha o caminho para o score
@onready var LabelQuestionP2 = $Question_P2 #Obtenha o caminho para a questão

# Called when the node enters the scene tree for the first time.
func _ready():
	ButtonAP2.pressed.connect(_onAnswerSelected, 1)
	ButtonBP2.pressed.connect(_onAnswerSelected, 2)
	ButtonCP2.pressed.connect(_onAnswerSelected, 3)
	ButtonDP2.pressed.connect(_onAnswerSelected, 4)
	
	LabelQuestionP2.text = ""
	ButtonAP2.text = ""
	ButtonBP2.text = ""
	ButtonCP2.text = ""
	ButtonDP2.text = ""

	var perguntasResource = load("res://jogo_oficial/Resource/bd_questions.tres")
	
	LabelScoreP2.text = "SCORE: " + str(scoreP2)
	
	for p in perguntasResource.perguntas:
		perguntas.append(p)
		print(p.pergunta)
		print(p.opcaoA)

	perguntas.shuffle()
	
# Função para começar a mostra as questões
func _onCountdownFinished():
	show_pergunta(idx)
	

# Função para captar a resposta do player
func show_pergunta(id : int):
	var perguntaAtual = perguntas[id]
	
	LabelQuestionP2.text = perguntaAtual.pergunta # Atribua o texto da pergunta à propriedade 'text' da label
	ButtonAP2.text = perguntaAtual.opcaoA # Atribua o texto da opção A à propriedade 'text' do button
	ButtonBP2.text = perguntaAtual.opcaoB # Atribua o texto da opção B à propriedade 'text' do button
	ButtonCP2.text = perguntaAtual.opcaoC # Atribua o texto da opção C à propriedade 'text' do button
	ButtonDP2.text = perguntaAtual.opcaoD # Atribua o texto da opção D à propriedade 'text' do button
	respostaCorretaAtual = perguntaAtual.respostaCorreta # Atribua a alternativa correta 
	buttonsDisabled = false
	
# Função para corrigir a resposta do player
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.as_text_keycode() == "J":
				answer = 1
				ButtonAP2.emit_signal("pressed")
			elif event.as_text_keycode() == "K":
				answer = 2
				ButtonBP2.emit_signal("pressed")
			elif event.as_text_keycode() == "L":
				answer = 3
				ButtonCP2.emit_signal("pressed")
			elif event.as_text_keycode() == "Ç":
				answer = 4
				ButtonDP2.emit_signal("pressed")
				
# Função para corrigir a resposta do player
func _onAnswerSelected():
	if buttonsDisabled:
		return
	buttonsDisabled = true
	
	if answer == respostaCorretaAtual:
		# Resposta correta
		print("Resposta correta!")
		scoreP2 = scoreP2 + 1
		LabelScoreP2.text = "SCORE: " + str(scoreP2)
		if answer == 1:
			ButtonAP2.add_theme_color_override("font_color", Color( 0, 1, 0, 1))
		elif answer == 2:
			ButtonBP2.add_theme_color_override("font_color", Color( 0, 1, 0, 1))
		elif answer == 3:
			ButtonCP2.add_theme_color_override("font_color", Color( 0, 1, 0, 1))
		elif answer == 4:
			ButtonDP2.add_theme_color_override("font_color", Color( 0, 1, 0, 1))
	
	
	else:
		# Resposta incorreta
		print("Resposta incorreta!")
		if answer == 1:
			ButtonAP2.add_theme_color_override("font_color", Color( 1, 0, 0, 1))
		elif answer == 2:
			ButtonBP2.add_theme_color_override("font_color", Color( 1, 0, 0, 1))
		elif answer == 3:
			ButtonCP2.add_theme_color_override("font_color", Color( 1, 0, 0, 1))
		elif answer == 4:
			ButtonDP2.add_theme_color_override("font_color", Color( 1, 0, 0, 1))
	
	await get_tree().create_timer(2.0).timeout
	next_Question()
	
#Função para mostrar a pergunta seguinte
func next_Question():
	ButtonAP2.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	ButtonBP2.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	ButtonCP2.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	ButtonDP2.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	
	idx = idx + 1
	if idx < perguntas.size():
		show_pergunta(idx)
	else: 
		print("Acabaram as perguntas")
		print("Pontuação final: ", scoreP2)

# Função para finalizar o jogo
func end_Game():
	print("Fim de jogo!")

