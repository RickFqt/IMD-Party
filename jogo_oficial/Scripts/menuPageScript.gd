extends Node2D

func new_game():
	get_tree().change_scene_to_file("res://jogo_oficial/Scenes/selectionPage.tscn")

func exit_game():
	get_tree().quit()

func credits():
	get_tree().change_scene_to_file("res://jogo_oficial/Scenes/credits.tscn")
