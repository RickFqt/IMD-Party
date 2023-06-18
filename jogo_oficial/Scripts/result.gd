extends Label

var resP1 = 0
var resP2 = 0
var winner = ""

var resultText = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = ""
	resP1 = Global.resultadoP1
	resP2 = Global.resultadoP2
	$"../coin".visible = false
	
	if resP1+resP2 == 0:
		resultText = "Placar final: \nPlayer 1 : " + str(resP1) + "\nPlayer 2 : " + str(resP2) + "\n\nEstudem mais!"
	else:
		if resP1 > resP2: 
			winner = "1"
			Global.infoPlayer1.ob_coins += 3
		elif resP1 < resP2: 
			winner = "2"
			Global.infoPlayer2.ob_coins += 3
		else:
			winner = "1 e 2"
			Global.infoPlayer1.ob_coins += 3
			Global.infoPlayer2.ob_coins += 3		
		
		resultText = "Placar final: \nPlayer 1 : " + str(resP1) + "\nPlayer 2 : " + str(resP2) + "\n\nPARABENS PLAYER " +  winner + "\n +3"
	
	mostrarResultado()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func mostrarResultado():
	var labelText = ""
	var fullTextLen = resultText.length()
	
	for i in range(fullTextLen):
		labelText += resultText[i]
		$".".text = labelText
		await get_tree().create_timer(0.1).timeout
	
	if resP1 + resP2 != 0:
		$"../coin".visible = true
	
	await get_tree().create_timer(3).timeout
	Global.trocar_cena("res://jogo_oficial/Scenes/map.tscn")
