extends Node2D


class_name TurnQueue

var active_character
var numero_turno
var semestre_atual
var camera_path

func initialize():
	numero_turno = 0
	semestre_atual = 1
	active_character = get_child(0)
	await play_turn()
	
func play_turn():
	if(active_character != null):
		
		#if(semestre_atual > 8):
		#	End Game
		
		# Inicia o turno do player
		await active_character.play_turn()
		
		# Troca o player
		var new_index : int = (active_character.get_index() + 1) % get_child_count()
		active_character = get_child(new_index)
		
		# Verifica se todos os jogadores já jogaram
		if(new_index == 0):
			change_to_minigame()
			
			# Atualiza os dados da partida
			numero_turno += 1
			if(numero_turno % 3 == 0):
				# O semestre trocou aeeee
				semestre_atual += 1
		else:
			print("mudou o player!")
			await play_turn()
		
		
func change_to_minigame():
	# ir pro minigame
	get_tree().change_scene_to_file("res://levels/minigame_test.tscn")
	# voltar do mini game


# TODO:
# Voltar dos minigames!
