extends Node2D

@onready var turnqueue := $TurnQueue as Node2D
#@onready var player1 := $TurnQueue/player1_table as CharacterBody2D
#@onready var player2 := $TurnQueue/player1_table2 as CharacterBody2D
@onready var camera := $camera as Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	turnqueue.initialize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
