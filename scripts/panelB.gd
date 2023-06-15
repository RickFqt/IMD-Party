extends Panel

signal countdown_finished

var idx : int
var score : int
var answer : int
var perguntas = []
var buttonsDisabled : bool
var respostaCorretaAtual : int

# Called when the node enters the scene tree for the first time.
func _ready():
	$ButtonA_P2.pressed.connect(_onAnswerSelected, 1)
	$ButtonB_P2.pressed.connect(_onAnswerSelected, 2)
	$ButtonC_P2.pressed.connect(_onAnswerSelected, 3)
	$ButtonD_P2.pressed.connect(_onAnswerSelected, 4)
	self.countdown_finished.connect(_onCountdownFinished)

	var perguntasResource = load("res://resource/bd_questions.tres")
	
	idx = 0
	score = 0
	
	for p in perguntasResource.perguntas:
		perguntas.append(p)
		print(p.pergunta)
		print(p.opcaoA)

	perguntas.shuffle()
	
func _onCountdownFinished():
	show_pergunta(idx)
	
	
func show_pergunta(id : int):
	var perguntaAtual = perguntas[id]
	var labelP2 = $Question_P2 #Obtenha o caminho para a label
	var ButtonAP2 = $ButtonA_P2 #Obtenha o caminho para o botão A
	var ButtonBP2 = $ButtonB_P2 #Obtenha o caminho para o botão B
	var ButtonCP2 = $ButtonC_P2 #Obtenha o caminho para o botão C
	var ButtonDP2 = $ButtonD_P2 #Obtenha o caminho para o botão D
	
	labelP2.text = perguntaAtual.pergunta # Atribua o texto da pergunta à propriedade 'text' da label
	ButtonAP2.text = perguntaAtual.opcaoA # Atribua o texto da opção A à propriedade 'text' do button
	ButtonBP2.text = perguntaAtual.opcaoB # Atribua o texto da opção B à propriedade 'text' do button
	ButtonCP2.text = perguntaAtual.opcaoC # Atribua o texto da opção C à propriedade 'text' do button
	ButtonDP2.text = perguntaAtual.opcaoD # Atribua o texto da opção D à propriedade 'text' do button
	respostaCorretaAtual = perguntaAtual.respostaCorreta # Atribua a alternativa correta 
	buttonsDisabled = false
	
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.as_text_keycode() == "J":
				answer = 1
				$ButtonA_P2.emit_signal("pressed")
			elif event.as_text_keycode() == "K":
				answer = 2
				$ButtonB_P2.emit_signal("pressed")
			elif event.as_text_keycode() == "L":
				answer = 3
				$ButtonC_P2.emit_signal("pressed")
			elif event.as_text_keycode() == "Ç":
				answer = 4
				$ButtonD_P2.emit_signal("pressed")
				
func _onAnswerSelected():
	if buttonsDisabled:
		return
	buttonsDisabled = true
	
	if answer == respostaCorretaAtual:
		# Resposta correta
		print("Resposta correta!")
		score = score + 1
		if answer == 1:
			$ButtonA_P2.add_theme_color_override("font_color", Color( 0, 1, 0, 1))
		elif answer == 2:
			$ButtonB_P2.add_theme_color_override("font_color", Color( 0, 1, 0, 1))
		elif answer == 3:
			$ButtonC_P2.add_theme_color_override("font_color", Color( 0, 1, 0, 1))
		elif answer == 4:
			$ButtonD_P2.add_theme_color_override("font_color", Color( 0, 1, 0, 1))
	
	
	else:
		# Resposta incorreta
		print("Resposta incorreta!")
		if answer == 1:
			$ButtonA_P2.add_theme_color_override("font_color", Color( 1, 0, 0, 1))
		elif answer == 2:
			$ButtonB_P2.add_theme_color_override("font_color", Color( 1, 0, 0, 1))
		elif answer == 3:
			$ButtonC_P2.add_theme_color_override("font_color", Color( 1, 0, 0, 1))
		elif answer == 4:
			$ButtonD_P2.add_theme_color_override("font_color", Color( 1, 0, 0, 1))
	
	await get_tree().create_timer(2.0).timeout
	next_Question()
	

func next_Question():
	$ButtonA_P2.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	$ButtonB_P2.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	$ButtonC_P2.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	$ButtonD_P2.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	
	idx = idx + 1
	if idx < perguntas.size():
		show_pergunta(idx)
	else: 
		print("Acabaram as perguntas")
		print("Pontuação final: ", score)
