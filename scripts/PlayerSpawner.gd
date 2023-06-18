extends Node2D


@onready var player = $CharacterBody2D
@onready var global = get_node("/root/Global")
var player_table1: Node2D = null
var player_table2: Node2D = null

func _ready():
	player_table1 = load(Global.player1Dir).instantiate()
	player_table1.position = global.infoPlayer1.location
	
	player_table2 = load(Global.player2Dir).instantiate()
	player_table2.position = global.infoPlayer2.location
	
	
