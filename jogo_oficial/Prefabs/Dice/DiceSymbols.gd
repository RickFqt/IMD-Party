# Code from:
# https://codeberg.org/Sosasees/2d-dice-in-godot
# Licensed under MIT License:
# https://codeberg.org/Sosasees/mit-license/src/branch/2022/LICENSE
# Copyright (c) Sosasees

extends Node2D


@onready var sprite : Sprite2D = get_node("HDSprite")


enum Symbol {
	NONE = 0,
	ONE = 1, TWO, THREE, FOUR, FIVE, SIX
}


func set_symbol(new_symbol : int) -> void:
	sprite.set_frame(new_symbol)
