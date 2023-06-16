extends Node2D

func new_game():
	get_tree().change_scene_to_file("res://levels/world_1.tscn")

func exit_game():
	get_tree().change_scene_to_file("res://levels/world_1.tscn")

func credits():
	get_tree().change_scene_to_file("res://levels/mini_game.tscn")
