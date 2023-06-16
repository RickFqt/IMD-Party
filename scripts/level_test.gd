extends Node2D

@onready var turnqueue := $TurnQueue as Node2D
#@onready var player1 := $TurnQueue/player1_table as CharacterBody2D
#@onready var player2 := $TurnQueue/player1_table2 as CharacterBody2D
@onready var camera := $camera as Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$TurnQueue/player1_table/anim.play("0_idle")
	$TurnQueue/player1_table2/anim.play("1_idle")
	turnqueue.initialize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
