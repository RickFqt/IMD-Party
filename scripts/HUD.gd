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
	
func _on_StartButton_pressed():
	hideAll()
	emit_signal("start_game")
	
func _on_ExitButton_pressed():
	hideAll()
	emit_signal("exit_game")
	
func _on_CreditsButton_pressed():
	hideAll()
	emit_signal("show_credits")
