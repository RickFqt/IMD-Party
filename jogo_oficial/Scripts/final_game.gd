extends Label

var diplomasP1 = Global.infoPlayer1.diplomas
var diplomasP2 = Global.infoPlayer2.diplomas
var ob_coinsP1 = Global.infoPlayer1.ob_coins
var ob_coinsP2 = Global.infoPlayer2.ob_coins
var opt_coinsP1 = Global.infoPlayer1.opt_coins
var opt_coinsP2 = Global.infoPlayer1.opt_coins

var winner = ""

var resultText = "Placar final: \n\n"
var tabelaP1 = "Player 1:   " + str(diplomasP1) + "   " + str(ob_coinsP1) + "   " + str(opt_coinsP1) + "\n"
var tabelaP2 = "Player 2:   " + str(diplomasP2) + "   " + str(ob_coinsP2) + "   " + str(opt_coinsP2) + "\n"
# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = ""
	$"../diploma".visible = false
	$"../coins1".visible = false
	$"../coins2".visible = false
	if diplomasP1 > diplomasP2: 
		resultText += tabelaP1
		resultText += tabelaP2
		resultText += "PARABENS PLAYER 1!!!"
	elif diplomasP1 < diplomasP2: 
		resultText += tabelaP2
		resultText += tabelaP1
		resultText += "PARABENS PLAYER 2!!!"
	else:
		if ob_coinsP1 > ob_coinsP2: 
			resultText += tabelaP1
			resultText += tabelaP2
			resultText += "PARABENS PLAYER 1!!!"
			
		elif ob_coinsP1 < ob_coinsP2: 
			resultText += tabelaP2
			resultText += tabelaP1
			resultText += "PARABENS PLAYER 2!!!"
			
		else:
			if opt_coinsP1 > opt_coinsP2: 
				resultText += tabelaP1
				resultText += tabelaP2
				resultText += "PARABENS PLAYER 1!!!"
			elif opt_coinsP1 < opt_coinsP2: 
				resultText += tabelaP2
				resultText += tabelaP1
				resultText += "PARABENS PLAYER 2!!!"
			else:
				resultText += tabelaP1
				resultText += tabelaP2
				resultText += "EMPATOU!!!"
		
	mostrarResultado()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func mostrarResultado():
	var labelText = ""
	var fullTextLen = resultText.length()
	
	for i in range(fullTextLen):
		labelText += resultText[i]
		$".".text = labelText
		await get_tree().create_timer(0.1).timeout
	
	$"../diploma".visible = true
	$"../coins1".visible = true
	$"../coins2".visible = true
	await get_tree().create_timer(3).timeout
	#Global.trocar_cena("res://jogo_oficial/Scenes/menuPage.tscn")
