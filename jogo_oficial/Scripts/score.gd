extends Control

var curr_player = 1

func initialize(n_player):
	curr_player = n_player

func _process(delta):
	var dip = ""
	var ob_coins = ""
	var opt_coins = ""
	if self.visible:
		if(curr_player == 1):
			dip = str(Global.infoPlayer1.diplomas)
			ob_coins = str(Global.infoPlayer1.ob_coins)
			opt_coins = str(Global.infoPlayer1.opt_coins)
		else:
			dip = str(Global.infoPlayer2.diplomas)
			ob_coins = str(Global.infoPlayer2.ob_coins)
			opt_coins = str(Global.infoPlayer2.opt_coins)
		$TextureRect/diplomas.text = dip
		$TextureRect/ob_coins.text = ob_coins
		$TextureRect/opt_coins.text = opt_coins
