extends Panel

var perguntas = []
# Called when the node enters the scene tree for the first time.
func _ready():
	var perguntasResource = load("res://resource/bd_questions.tres")
	for p in perguntasResource.perguntas:
		perguntas.append(p)
		print(p.pergunta)
		print(p.opcaoA)

	
