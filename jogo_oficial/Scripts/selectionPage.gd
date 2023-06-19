extends Node2D

var ready_p1 = false
var ready_p2 = false


func _ready():
	$"Player 2".set_process_input(false)
	$"Player 1/selectionTurn".visible = true
	
func goToGame():
	Global.trocar_cena("res://jogo_oficial/Scenes/map.tscn")


func _on_p_1_ready():
	ready_p1 = true
	$"Player 1".set_process_input(false)
	$"Player 2".set_process_input(true)
	$"Player 1/selectionTurn".visible = false
	$"Player 2/selectionTurn".visible = true



func _on_p_2_ready():
	ready_p2 = true
	goToGame()
