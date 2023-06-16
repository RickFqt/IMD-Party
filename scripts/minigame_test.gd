extends Node2D

@onready var control = get_node("/root/controle")

# Called when the node enters the scene tree for the first time.
func _ready():
	await play_minigame()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_minigame():
	await get_tree().create_timer(2).timeout
	control.trocar_cena("res://levels/level_test.tscn")
