extends Node2D

func new_game():
	get_tree().change_scene_to_file("res://levels/world_1.tscn")

func exit_game():
	get_tree().quit()

func credits():
	get_tree().change_scene_to_file("res://levels/credits.tscn")
