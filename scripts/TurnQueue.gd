extends Node2D


class_name TurnQueue

var active_character
var i = 10 # <---- mudar depois!
var camera_path

func initialize():
	active_character = get_child(0)
	await play_turn()
	
func play_turn():
	if(active_character != null):
		
		# Inicia o turno do player
		await active_character.play_turn()
		
		# Troca o player
		var new_index : int = (active_character.get_index() + 1) % get_child_count()
		active_character = get_child(new_index)
		i = i - 1
		change_to_minigame(new_index)
		if i != 0:
			print("mudou o player!")
			await play_turn()
		
		
func change_to_minigame(new_index):
	if new_index == 0:
		get_tree().change_scene_to_file("res://levels/minigame.tscn")
			
		# ir pro minigame
		# voltar pro mini game


# TODO:
# Mudar pros minigames!
