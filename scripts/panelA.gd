extends Panel

signal countdown_finished
signal endTime

var idx : int
var scoreP1 : int
var answer : int
var perguntas = []
var buttonsDisabled : bool
var respostaCorretaAtual : int

# Called when the node enters the scene tree for the first time.
func _ready():
	$ButtonA_P1.pressed.connect(_onAnswerSelected, 1)
	$ButtonB_P1.pressed.connect(_onAnswerSelected, 2)
	$ButtonC_P1.pressed.connect(_onAnswerSelected, 3)
	$ButtonD_P1.pressed.connect(_onAnswerSelected, 4)
	self.countdown_finished.connect(_onCountdownFinished)

	var perguntasResource = load("res://resource/bd_questions.tres")
	
	idx = 0
	scoreP1 = 0
	
	$ScoreLabel_P1.text = "SCORE: " + str(scoreP1)
	
	for p in perguntasResource.perguntas:
		perguntas.append(p)
		print(p.pergunta)
		print(p.opcaoA)

	perguntas.shuffle()
	
func _onCountdownFinished():
	show_pergunta(idx)
	
func show_pergunta(id : int):
	var perguntaAtual = perguntas[id]
	var labelP1 = $Question_P1 #Obtenha o caminho para a label
	var ButtonAP1 = $ButtonA_P1 #Obtenha o caminho para o botão A
	var ButtonBP1 = $ButtonB_P1 #Obtenha o caminho para o botão B
	var ButtonCP1 = $ButtonC_P1 #Obtenha o caminho para o botão C
	var ButtonDP1 = $ButtonD_P1 #Obtenha o caminho para o botão D
	
	labelP1.text = perguntaAtual.pergunta # Atribua o texto da pergunta à propriedade 'text' da label
	ButtonAP1.text = perguntaAtual.opcaoA # Atribua o texto da opção A à propriedade 'text' do button
	ButtonBP1.text = perguntaAtual.opcaoB # Atribua o texto da opção B à propriedade 'text' do button
	ButtonCP1.text = perguntaAtual.opcaoC # Atribua o texto da opção C à propriedade 'text' do button
	ButtonDP1.text = perguntaAtual.opcaoD # Atribua o texto da opção D à propriedade 'text' do button
	respostaCorretaAtual = perguntaAtual.respostaCorreta # Atribua a alternativa correta 
	buttonsDisabled = false
	
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.as_text_keycode() == "A":
				answer = 1
				$ButtonA_P1.emit_signal("pressed")
			elif event.as_text_keycode() == "S":
				answer = 2
				$ButtonB_P1.emit_signal("pressed")
			elif event.as_text_keycode() == "D":
				answer = 3
				$ButtonC_P1.emit_signal("pressed")
			elif event.as_text_keycode() == "F":
				answer = 4
				$ButtonD_P1.emit_signal("pressed")
				
func _onAnswerSelected():
	if buttonsDisabled:
		return
	buttonsDisabled = true
	
	if answer == respostaCorretaAtual:
		# Resposta correta
		print("Resposta correta!")
		scoreP1 = scoreP1 + 1
		$ScoreLabel_P1.text = "SCORE: " + str(scoreP1)
		if answer == 1:
			$ButtonA_P1.add_theme_color_override("font_color", Color( 0, 1, 0, 1))
		elif answer == 2:
			$ButtonB_P1.add_theme_color_override("font_color", Color( 0, 1, 0, 1))
		elif answer == 3:
			$ButtonC_P1.add_theme_color_override("font_color", Color( 0, 1, 0, 1))
		elif answer == 4:
			$ButtonD_P1.add_theme_color_override("font_color", Color( 0, 1, 0, 1))
	
	
	else:
		# Resposta incorreta
		print("Resposta incorreta!")
		if answer == 1:
			$ButtonA_P1.add_theme_color_override("font_color", Color( 1, 0, 0, 1))
		elif answer == 2:
			$ButtonB_P1.add_theme_color_override("font_color", Color( 1, 0, 0, 1))
		elif answer == 3:
			$ButtonC_P1.add_theme_color_override("font_color", Color( 1, 0, 0, 1))
		elif answer == 4:
			$ButtonD_P1.add_theme_color_override("font_color", Color( 1, 0, 0, 1))
	
	await get_tree().create_timer(2.0).timeout
	next_Question()
	

func next_Question():
	$ButtonA_P1.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	$ButtonB_P1.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	$ButtonC_P1.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	$ButtonD_P1.add_theme_color_override("font_color", Color( 0, 0, 0, 1))
	
	idx = idx + 1
	if idx < perguntas.size():
		show_pergunta(idx)
	else: 
		print("Acabaram as perguntas")
		print("Pontuação final: ", scoreP1)
		
func end_Game():
	print("Fim de jogo!")


