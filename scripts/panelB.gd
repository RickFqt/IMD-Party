extends Panel

var perguntas = []
var respostaCorretaAtual : int
# Called when the node enters the scene tree for the first time.
func _ready():
	$ButtonA_P2.connect("pressed", _onAnswerSelected, 1)
	$ButtonB_P2.connect("pressed", _onAnswerSelected, 2)
	$ButtonC_P2.connect("pressed", _onAnswerSelected, 3)
	$ButtonD_P2.connect("pressed", _onAnswerSelected, 4)

	var perguntasResource = load("res://resource/bd_questions.tres")
	for p in perguntasResource.perguntas:
		perguntas.append(p)
		print(p.pergunta)
		print(p.opcaoA)

	perguntas.shuffle()
	
	show_perguntas()
	
func show_perguntas():
	var perguntaAtual = perguntas[0]
	var labelP2 = $Question_P2 #Obtenha o caminho para a label
	var ButtonAP2 = $ButtonA_P2 #Obtenha o caminho para o botão A
	var ButtonBP2 = $ButtonB_P2 #Obtenha o caminho para o botão B
	var ButtonCP2 = $ButtonC_P2 #Obtenha o caminho para o botão C
	var ButtonDP2 = $ButtonD_P2 #Obtenha o caminho para o botão D
	
	labelP2.text = perguntaAtual.pergunta # Atribua o texto da pergunta à propriedade 'text' da label
	ButtonAP2.text = perguntaAtual.opcaoA # Atribua o texto da opção A à propriedade 'text' do button
	ButtonBP2.text = perguntaAtual.opcaoB # Atribua o texto da opção A à propriedade 'text' do button
	ButtonCP2.text = perguntaAtual.opcaoC # Atribua o texto da opção A à propriedade 'text' do button
	ButtonDP2.text = perguntaAtual.opcaoD # Atribua o texto da opção A à propriedade 'text' do button
	respostaCorretaAtual = perguntaAtual.respostaCorreta
	
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.as_text_keycode() == "A":
				$ButtonA_P2.emit_signal("pressed")
			elif event.as_text_keycode() == "S":
				$ButtonB_P2.emit_signal("pressed")
			elif event.as_text_keycode() == "D":
				$ButtonC_P2.emit_signal("pressed")
			elif event.as_text_keycode() == "F":
				$ButtonD_P2.emit_signal("pressed")
				
func _onAnswerSelected(answer):
	if answer == respostaCorretaAtual:
		# Resposta correta
		print("Resposta correta!")
	else:
		# Resposta incorreta
		print("Resposta incorreta!")
