extends TextureRect

var n_moedas

func processClass(n_player):
	n_moedas = 0
	$coin.visible = false
	var labelText = ""
	
	labelText = await printString(labelText, "..............")
	get_tree().create_timer(1).timeout
	
	var tem_professor = (randi() % 100 + 1)
	if tem_professor > 50:
		labelText = await printString(labelText, "!\n")
		labelText = await printString(labelText, "THANOS estava na sala!\nTHANOS diz: \"BON DIA!\"\n")
		
		
		if tem_professor > 90:
			n_moedas = 3
		elif tem_professor > 70:
			n_moedas = 2
		else:
			n_moedas = 1
		
		if(n_player == 1):
			Global.infoPlayer1.opt_coins += n_moedas
		else:
			Global.infoPlayer2.opt_coins += n_moedas
		
		labelText = await printString(labelText, "+" + str(n_moedas))
		$coin.visible = true

	else:
		labelText = await printString(labelText, "\nNada acontece...")
	
	await get_tree().create_timer(3).timeout
	
	$coin.visible = false
	$Label.text = ""
	self.visible = false
	
	return n_moedas
	
func printString(text, word):
	var fullTextLen = word.length()
	for i in range(fullTextLen):
		text += word[i]
		$Label.text = text
		await get_tree().create_timer(0.1).timeout
	
	return text
