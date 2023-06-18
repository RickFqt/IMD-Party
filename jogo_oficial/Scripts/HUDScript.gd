extends CanvasLayer

signal start_game
signal exit_game
signal show_credits

func hideAll():
	$StartButton.hide()
	$ExitButton.hide()
	$CreditsButton.hide()
	$IMD.hide()
	$Party.hide()
	
# Função para ir para a seleção dos players
func _on_StartButton_pressed():
	hideAll()
	emit_signal("start_game")

# Função para fechar o jogo
func _on_ExitButton_pressed():
	hideAll()
	emit_signal("exit_game")
	

# Função para ir para a tela de créditos
func _on_CreditsButton_pressed():
	hideAll()
	emit_signal("show_credits")
