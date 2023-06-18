extends Control

var boy1 = "res://jogo_oficial/Players/boy1.tscn"
var boy2 = "res://jogo_oficial/Players/boy2.tscn"
var girl1 = "res://jogo_oficial/Players/girl1.tscn"
var girl2 = "res://jogo_oficial/Players/girl2.tscn"

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.as_text_keycode() == "A":
				$"Boy 1/TextureRect".visible = true
				$"Boy 2/TextureRect2".visible = false
				$"Girl 1/TextureRect3".visible = false
				$"Girl 2/TextureRect4".visible = false
				Global.player1Dir = boy1
				
			elif event.as_text_keycode() == "S":
				$"Boy 1/TextureRect".visible = false
				$"Boy 2/TextureRect2".visible = true
				$"Girl 1/TextureRect3".visible = false
				$"Girl 2/TextureRect4".visible = false
				Global.player1Dir = boy2
				
			elif event.as_text_keycode() == "D":
				$"Boy 1/TextureRect".visible = false
				$"Boy 2/TextureRect2".visible = false
				$"Girl 1/TextureRect3".visible = true
				$"Girl 2/TextureRect4".visible = false
				Global.player1Dir = girl1
				
			elif event.as_text_keycode() == "F":
				$"Boy 1/TextureRect".visible = false
				$"Boy 2/TextureRect2".visible = false
				$"Girl 1/TextureRect3".visible = false
				$"Girl 2/TextureRect4".visible = true
				Global.player1Dir = girl2
				

