extends Control

@onready var boy1 = $"Boy 1" #Obtenha o caminho para o botão A
@onready var boy2 = $"Boy 2" #Obtenha o caminho para o botão B
@onready var girl1 = $"Girl 1" #Obtenha o caminho para o botão C
@onready var girl2 = $"Girl 2" #Obtenha o caminho para o botão D

var playerSelected

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.as_text_keycode() == "J":
				$"Boy 1/TextureRect".visible = true
				$"Boy 2/TextureRect2".visible = false
				$"Girl 1/TextureRect3".visible = false
				$"Girl 2/TextureRect4".visible = false
			elif event.as_text_keycode() == "K":
				$"Boy 1/TextureRect".visible = false
				$"Boy 2/TextureRect2".visible = true
				$"Girl 1/TextureRect3".visible = false
				$"Girl 2/TextureRect4".visible = false
			elif event.as_text_keycode() == "L":
				$"Boy 1/TextureRect".visible = false
				$"Boy 2/TextureRect2".visible = false
				$"Girl 1/TextureRect3".visible = true
				$"Girl 2/TextureRect4".visible = false
			elif event.as_text_keycode() == "Ç":
				$"Boy 1/TextureRect".visible = false
				$"Boy 2/TextureRect2".visible = false
				$"Girl 1/TextureRect3".visible = false
				$"Girl 2/TextureRect4".visible = true

