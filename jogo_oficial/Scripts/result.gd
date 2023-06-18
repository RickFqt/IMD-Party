extends Label

var resultText = "Placar final: \n Player 1 : " + "X" + "\n Player 2 : " + "Y" + "\nPARABENS PLAYER A\n +5"
# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = ""
	$"../coin".visible = false
	mostrarResultado()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func mostrarResultado():
	var labelText = ""
	var fullTextLen = resultText.length()
	
	for i in range(fullTextLen):
		labelText += resultText[i]
		$".".text = labelText
		await get_tree().create_timer(0.2).timeout
	$"../coin".visible = true
	
