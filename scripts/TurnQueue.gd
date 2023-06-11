extends Node2D


class_name TurnQueue

var active_character
var i = 10

func _ready():
	active_character = get_child(0)
	print("batata")
	await play_turn()
	
func play_turn():
	if(active_character != null):
		await active_character.play_turn()
		var new_index : int = (active_character.get_index() + 1) % get_child_count()
		# if new_index == 0 --> mini-game!
		active_character = get_child(new_index)
		i = i - 1
		if i != 0:
			print("mudou o player!")
			await play_turn()
