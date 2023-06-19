extends Label

signal continueToScene

var resultText = "Bem-vindos ao IMD Party,\nNesta aventura voces competiram entre si para ver quem conseguira se formar!"
# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = ""
	$"../Button".visible = false
	$"../TextureRect".visible = false
	mostrarResultado()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func mostrarResultado():
	var labelText = ""
	var fullTextLen = resultText.length()
	
	for i in range(fullTextLen):
		labelText += resultText[i]
		$".".text = labelText
		await get_tree().create_timer(0.05).timeout
	await get_tree().create_timer(3).timeout
	
	resultText = "Para rodar o dado aperter ENTER/SPACE\n\nPara selecionar uma opcao nos minijogos, clique na tecla correspondente:\n\nJogador 1: Q W A S\n\nJogador 2: I O K L\n\nBOA SORTE!!!\n"
	
	labelText = ""
	fullTextLen = resultText.length()
	
	for i in range(fullTextLen):
		labelText += resultText[i]
		$".".text = labelText
		await get_tree().create_timer(0.05).timeout
	
	$"../Button".visible = true
	$"../TextureRect".visible = true
	continueToScene.emit()
	

