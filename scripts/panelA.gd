extends Panel

var perguntas = []
# Called when the node enters the scene tree for the first time.
func _ready():
	var perguntasResource = load("res://resource/bd_questions.tres")
	for p in perguntasResource.perguntas:
		perguntas.append(p)
		print(p.pergunta)
		print(p.opcaoA)

	perguntas.shuffle()
	
	show_perguntas()
	
func show_perguntas():
	var perguntaAtual = perguntas[0]
	var labelP1 = $Question_P1 #Obtenha o caminho para a label
	var ButtonAP1 = $ButtonA_P1 #Obtenha o caminho para o botão A
	var ButtonBP1 = $ButtonB_P1 #Obtenha o caminho para o botão B
	var ButtonCP1 = $ButtonC_P1 #Obtenha o caminho para o botão C
	var ButtonDP1 = $ButtonD_P1 #Obtenha o caminho para o botão D
	labelP1.text = perguntaAtual.pergunta # Atribua o texto da pergunta à propriedade 'text' da label
	ButtonAP1.text = perguntaAtual.opcaoA # Atribua o texto da opção A à propriedade 'text' do button
	ButtonBP1.text = perguntaAtual.opcaoB # Atribua o texto da opção A à propriedade 'text' do button
	ButtonCP1.text = perguntaAtual.opcaoC # Atribua o texto da opção A à propriedade 'text' do button
	ButtonDP1.text = perguntaAtual.opcaoD # Atribua o texto da opção A à propriedade 'text' do button
