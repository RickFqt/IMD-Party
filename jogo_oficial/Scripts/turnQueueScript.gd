extends Node2D

# "Classe" que controla os turnos entre os jogadores

# @onready variables
@onready var global = get_node("/root/Global")
@onready var player_table1 = $player_table1 as CharacterBody2D
@onready var player_table2 = $player_table2 as CharacterBody2D

# Variables
var active_character
var numero_turno = 1
var semestre_atual = 1
var continue_turns = false

# Signals received
signal player_finished_turn


# Função de inicialização
func initialize():
	
	if(!global.players_inicializados):
		# Inicializa as informacoes do jogo pela primeira vez
		
		# Salva as informações no global
		global.inicializar_players(player_table1.position, player_table1.curr_position, player_table1.moedas_obrigatorias, player_table1.moedas_optativas, player_table1.n_diplomas,
								player_table2.position, player_table2.curr_position, player_table2.moedas_obrigatorias, player_table2.moedas_optativas, player_table2.n_diplomas,
								semestre_atual, numero_turno)
	else:
		# Carrega as informacoes ja armazenadas no global
		load_game()
	
	# Seleciona o primeiro player a jogar
	active_character = get_child(0)
	
	await play_turn()
	
# Função para contralar as rodadas
func play_turn():
	
	print("semestre atual: ", semestre_atual)
	print("turno atual: ", numero_turno)
	if(active_character != null):
		
		if semestre_atual > 5:
			Global.trocar_cena("res://jogo_oficial/Scenes/final_game.tscn")
		
		# Inicia o turno do player
		await active_character.play_turn()
		
		# Indica o fim do turno do player
		continue_turns = false
		player_finished_turn.emit()
		
		# Espera para iniciar o turno do próximo player, se necessario
		while !continue_turns:
			# print("batata")
			await get_tree().create_timer(2).timeout
		
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
		
# Função para iniciar um mini-game
func change_to_minigame():
	# ir pro minigame
	save_game()
	Global.trocarBanco()
	global.trocar_cena("res://jogo_oficial/Scenes/minigamePage.tscn")
	#global.trocar_cena("res://testes/levels/minigame_test.tscn")

# Função para carregar as informações do global
func load_game():
	player_table1.position = global.infoPlayer1.location
	player_table1.curr_position = global.infoPlayer1.index_location
	player_table1.moedas_obrigatorias = global.infoPlayer1.ob_coins 
	player_table1.moedas_optativas = global.infoPlayer1.opt_coins
	player_table1.n_diplomas = global.infoPlayer1.diplomas
	
	player_table2.position = global.infoPlayer2.location
	player_table2.curr_position = global.infoPlayer2.index_location
	player_table2.moedas_obrigatorias = global.infoPlayer2.ob_coins 
	player_table2.moedas_optativas = global.infoPlayer2.opt_coins
	player_table2.n_diplomas = global.infoPlayer2.diplomas
	
	semestre_atual = global.semestre
	numero_turno = global.rodada
	
# Função para salvar as informações no global
func save_game():
	global.update_global(player_table1.position, player_table1.curr_position, player_table1.moedas_obrigatorias, player_table1.moedas_optativas, player_table1.n_diplomas,
							player_table2.position, player_table2.curr_position, player_table2.moedas_obrigatorias, player_table2.moedas_optativas, player_table2.n_diplomas,
							semestre_atual, numero_turno)

# Função que checa quando pode continuar o turno
func _on_level_continue_turns():
	#print("continue turns true!")
	continue_turns = true
