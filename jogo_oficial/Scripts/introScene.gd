extends Node2D

func  _ready():
	self.set_process_input(false)
	

func _input(event):
	if event.is_action_pressed("roll_dice"):
		get_tree().change_scene_to_file("res://jogo_oficial/Scenes/selectionPage.tscn")


func _on_continue_to_scene():
	self.set_process_input(true)
