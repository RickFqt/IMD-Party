extends Node2D

@onready var turnqueue := $TurnQueue as Node2D
@onready var player1 := $TurnQueue/player1_table as CharacterBody2D
@onready var player2 := $TurnQueue/player1_table2 as CharacterBody2D
@onready var camera := $camera as Camera2D
@onready var control = get_node("/root/controle")
var reached_star = false
signal continue_turns

# Called when the node enters the scene tree for the first time.
func _ready():
	$TurnQueue/player1_table/anim.play("0_idle")
	$TurnQueue/player1_table2/anim.play("1_idle")
	if(!control.loc_inicializado):
		control.inicializar_locations($GetLocations.get_locations())
		inicial_star()
	print("DIPLOMA NA POSICAO -> ", control.star_location.index)
	for i in $GetLocations.get_child_count():
		if i != control.star_location.index:
			$GetLocations.get_child(i).visible = false
	turnqueue.initialize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func inicial_star():
	var index = (randi() % 10 + 14)
	control.inicializar_star(index)
	
func randomize_star():
	
	var possible_locations = []
	
	var idx_player1 = player1.curr_position
	var idx_player2 = player2.curr_position
	
	# TODO: Mudar para considerar o tile que dá a volta no mapa!
	for i in range(idx_player1 + 5, idx_player1 + 8):
		if(i != idx_player2 and !control.locations[i].special):
			possible_locations.append(i)
	
	# TODO: Mudar para considerar o tile que dá a volta no mapa!
	for i in range(idx_player2 + 5, idx_player2 + 8):
		if(i != idx_player1 and !control.locations[i].special):
			possible_locations.append(i)
	
	var the_chosen_one = (randi() % possible_locations.size() )
	
	return possible_locations[the_chosen_one]


func _on_player1_reached_star():
	reached_star = true

func _on_player2_reached_star():
	reached_star = true


func _on_turn_queue_player_finished_turn():
	#print("player finished turn!")
	if(reached_star):
		
		$GetLocations.get_child(control.star_location.index).visible = false
		var new_star_index_location = randomize_star()
		control.atualizar_star( new_star_index_location )
		$GetLocations.get_child(control.star_location.index).visible = true
		print("MUDOUU!! DIPLOMA AGORA NA POSICAO -> ", control.star_location.index)
		
		
		
		reached_star = false
	continue_turns.emit()
