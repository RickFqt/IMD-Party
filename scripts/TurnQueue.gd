extends Node2D


class_name TurnQueue

@onready var control = get_node("/root/controle")
var active_character
var numero_turno = 1
var semestre_atual = 1
var camera_path

func initialize():
	
	if(!control.players_inicializados):		
		control.inicializar_players($player1_table.position, $player1_table.curr_position, $player1_table.moedas_obrigatorias, $player1_table.moedas_optativas, $player1_table.n_diplomas,
								$player1_table2.position, $player1_table2.curr_position, $player1_table2.moedas_obrigatorias, $player1_table2.moedas_optativas, $player1_table.n_diplomas,
								semestre_atual, numero_turno)
	else:
		load_game()
	
	get_child(0).player_number = 0
	get_child(1).player_number = 1
	active_character = get_child(0)
	
	await play_turn()
	
func play_turn():
	
	print("semestre atual: ", semestre_atual)
	print("turno atual: ", numero_turno)
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
			
			# Atualiza os dados da partida
			if(numero_turno % 3 == 0):
				# O semestre trocou aeeee
				semestre_atual += 1
			numero_turno += 1
			change_to_minigame()
		else:
			print("mudou o player!")
			await play_turn()
		
		
func change_to_minigame():
	# ir pro minigame
	save_game()
	control.trocar_cena("res://levels/minigame_test.tscn")

func load_game():
	$player1_table.position = control.player1.location
	$player1_table.curr_position = control.player1.index_location
	$player1_table.moedas_obrigatorias = control.player1.ob_coins 
	$player1_table.moedas_optativas = control.player1.opt_coins
	$player1_table.n_diplomas = control.player1.diplomas
	
	$player1_table2.position = control.player2.location
	$player1_table2.curr_position = control.player2.index_location
	$player1_table2.moedas_obrigatorias = control.player2.ob_coins 
	$player1_table2.moedas_optativas = control.player2.opt_coins
	$player1_table2.n_diplomas = control.player2.diplomas
	
	semestre_atual = control.semestre
	numero_turno = control.turno
	
func save_game():
	control.update_control($player1_table.position, $player1_table.curr_position, $player1_table.moedas_obrigatorias, $player1_table.moedas_optativas, $player1_table.n_diplomas,
						   $player1_table2.position, $player1_table2.curr_position, $player1_table2.moedas_obrigatorias, $player1_table2.moedas_optativas, $player1_table.n_diplomas,
						   semestre_atual, numero_turno)
