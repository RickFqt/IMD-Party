extends Node2D

# Nível de tabuleiro

# @onready variables
@onready var turnqueue := $TurnQueue as Node2D
# @onready var player1 := $TurnQueue/player1_table as CharacterBody2D
# @onready var player2 := $TurnQueue/player1_table2 as CharacterBody2D
@onready var global = get_node("/root/Global")

# Variables
var reached_star = false # Armazena se um jogador passou por uma casa de diploma em seu turno

#Signals received
signal continue_turns # Sinal que permite a continuação dos turnos dos jogadores

# Called when the node enters the scene tree for the first time.
func _ready():
	turnqueue.player_table1.get_child(0).play("Idle")
	turnqueue.player_table2.get_child(0).play("Idle")
	
	if(!global.loc_inicializado):
		# Inicializa os locais pela primeira vez, junto com a casa de diploma
		global.inicializar_locations($GetLocations.get_locations())
		inicial_star()
	print("DIPLOMA NA POSICAO -> ", global.star_location.index)
	
	# Deixa visível apenas o sprite da casa de diploma atual
	for i in $GetLocations.get_child_count():
		if i != global.star_location.index:
			$GetLocations.get_child(i).visible = false
	turnqueue.initialize()

# Inicializa a localização da estrela atual
func inicial_star():
	var index = (randi() % 10 + 14)
	global.inicializar_star(index)
	
	
# Retorna um novo INDICE para a casa de diploma "aleatoriamente"
func randomize_star():
	
	var possible_locations = []
	
	var idx_player1 = turnqueue.get_child(0).curr_position
	var idx_player2 = turnqueue.get_child(1).curr_position
	
	# Numero que indica quantas casas devem ser adicionadas ao valor real do indice
	# (considerado apenas quando o jogador esta perto do tile que roda o mapa)
	var offset_map_turn = 0
	for i in range(idx_player1 + 5, idx_player1 + 8):
		
		# Verifica se o indice esta no inicio do mapa
		offset_map_turn = 0
		if i <= 4:
			offset_map_turn = i + 5
		
		if(i != idx_player2 and !global.locations[i].special):
			possible_locations.append(i + offset_map_turn)
	
	for i in range(idx_player2 + 5, idx_player2 + 8):
		
		# Verifica se o indice esta no inicio do mapa
		offset_map_turn = 0
		if i <= 4:
			offset_map_turn = i + 5
		
		if(i != idx_player1 and !global.locations[i].special):
			possible_locations.append(i + offset_map_turn)
	
	var the_chosen_one = (randi() % possible_locations.size() )
	
	return possible_locations[the_chosen_one]

# Função para sinalizar se o player 1 passou pela casa de diploma 
func _on_player1_reached_star():
	reached_star = true

# Função para sinalizar se o player 2 passou pela casa de diploma 
func _on_player2_reached_star():
	reached_star = true

# Função que checa se algum player passou pela casa do diploma
func _on_turn_queue_player_finished_turn():
	
	if(reached_star):
		
		# "Esconde" a casa de diploma antiga
		$GetLocations.get_child(global.star_location.index).visible = false
		
		# Gera uma nova casa de diploma, e salva no global
		var new_star_index_location = randomize_star()
		global.atualizar_star( new_star_index_location )
		
		# Deixa visível a casa de diploma atual
		$GetLocations.get_child(global.star_location.index).visible = true
		print("MUDOUU!! DIPLOMA AGORA NA POSICAO -> ", global.star_location.index)
		
		
		
		reached_star = false
	continue_turns.emit()
