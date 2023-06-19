extends TextureRect


signal end_buy_turn
signal buy

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("key_1"):
			emit_signal("buy")
			emit_signal("end_buy_turn")
			self.visible = false
			
		elif event.is_action_pressed("key_0"):
			emit_signal("end_buy_turn")
			self.visible = false


