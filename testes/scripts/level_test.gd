extends Node2D

# Nível de tabuleiro

@onready var turnqueue := $TurnQueue as Node2D
@onready var player1 := $TurnQueue/player1_table as CharacterBody2D
@onready var player2 := $TurnQueue/player1_table2 as CharacterBody2D
#@onready var camera := $camera as Camera2D
@onready var control = get_node("/root/controle")

var reached_star = false # Armazena se um jogador passou por uma casa de diploma em seu turno
signal continue_turns # Sinal que permite a continuação dos turnos dos jogadores

# Called when the node enters the scene tree for the first time.
func _ready():
	$TurnQueue/player1_table/anim.play("0_idle")
	$TurnQueue/player1_table2/anim.play("1_idle")
	
	
	if(!control.loc_inicializado):
		# Inicializa os locais pela primeira vez, junto com a casa de diploma
		control.inicializar_locations($GetLocations.get_locations())
		inicial_star()
	print("DIPLOMA NA POSICAO -> ", control.star_location.index)
	
	# Deixa visível apenas o sprite da casa de diploma atual
	for i in $GetLocations.get_child_count():
		if i != control.star_location.index:
			$GetLocations.get_child(i).visible = false
	turnqueue.initialize()

# Inicializa a localização da estrela atual
func inicial_star():
	var index = (randi() % 10 + 14)
	control.inicializar_star(index)
	
	
# Retorna um novo INDICE para a casa de diploma "aleatoriamente"
func randomize_star():
	
	var possible_locations = []
	
	var idx_player1 = player1.curr_position
	var idx_player2 = player2.curr_position
	
	# Numero que indica quantas casas devem ser adicionadas ao valor real do indice
	# (considerado apenas quando o jogador esta perto do tile que roda o mapa)
	var offset_map_turn = 0
	for i in range(idx_player1 + 5, idx_player1 + 8):
		
		# Verifica se o indice esta no inicio do mapa
		offset_map_turn = 0
		if i <= 4:
			offset_map_turn = i + 5
		
		if(i != idx_player2 and !control.locations[i].special):
			possible_locations.append(i + offset_map_turn)
	
	for i in range(idx_player2 + 5, idx_player2 + 8):
		
		# Verifica se o indice esta no inicio do mapa
		offset_map_turn = 0
		if i <= 4:
			offset_map_turn = i + 5
		
		if(i != idx_player1 and !control.locations[i].special):
			possible_locations.append(i + offset_map_turn)
	
	var the_chosen_one = (randi() % possible_locations.size() )
	
	return possible_locations[the_chosen_one]


func _on_player1_reached_star():
	reached_star = true

func _on_player2_reached_star():
	reached_star = true

# Funcao que checa se algum player passou pela casa do diploma
func _on_turn_queue_player_finished_turn():
	
	if(reached_star):
		
		# "Esconde" a casa de diploma antiga
		$GetLocations.get_child(control.star_location.index).visible = false
		
		# Gera uma nova casa de diploma, e salva no control
		var new_star_index_location = randomize_star()
		control.atualizar_star( new_star_index_location )
		
		# Deixa visível a casa de diploma atual
		$GetLocations.get_child(control.star_location.index).visible = true
		print("MUDOUU!! DIPLOMA AGORA NA POSICAO -> ", control.star_location.index)
		
		
		
		reached_star = false
	continue_turns.emit()
