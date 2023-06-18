extends Control

var boy1 = "res://jogo_oficial/Players/boy1.tscn"
var boy2 = "res://jogo_oficial/Players/boy2.tscn"
var girl1 = "res://jogo_oficial/Players/girl1.tscn"
var girl2 = "res://jogo_oficial/Players/girl2.tscn"

signal p2_ready

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("key_i"):
			$"Boy 1/TextureRect".visible = true
			$"Boy 2/TextureRect2".visible = false
			$"Girl 1/TextureRect3".visible = false
			$"Girl 2/TextureRect4".visible = false
			Global.player2Dir = boy1
			
		elif event.is_action_pressed("key_o"):
			$"Boy 1/TextureRect".visible = false
			$"Boy 2/TextureRect2".visible = true
			$"Girl 1/TextureRect3".visible = false
			$"Girl 2/TextureRect4".visible = false
			Global.player2Dir = boy2
			
		elif event.is_action_pressed("key_k"):
			$"Boy 1/TextureRect".visible = false
			$"Boy 2/TextureRect2".visible = false
			$"Girl 1/TextureRect3".visible = true
			$"Girl 2/TextureRect4".visible = false
			Global.player2Dir = girl1
			
		elif event.is_action_pressed("key_l"):
			$"Boy 1/TextureRect".visible = false
			$"Boy 2/TextureRect2".visible = false
			$"Girl 1/TextureRect3".visible = false
			$"Girl 2/TextureRect4".visible = true
			Global.player2Dir = girl2
		elif event.is_action_pressed("roll_dice"):
			emit_signal("p2_ready")

