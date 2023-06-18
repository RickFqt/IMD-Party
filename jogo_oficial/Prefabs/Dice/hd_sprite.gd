# Code from:
# https://codeberg.org/Sosasees/2d-dice-in-godot
# Licensed under MIT License:
# https://codeberg.org/sosasees/mit-license/raw/branch/no-year/LICENSE
# Copyright (c) Sosasees

@tool extends Sprite2D

@export var texture_scale : float = 1.0: #setget set_texture_scale, get_texture_scale
	get = get_texture_scale,
	set = set_texture_scale

func get_texture_scale() -> float:
	return texture_scale
func set_texture_scale(new_texture_scale : float) -> void:
	texture_scale = new_texture_scale
	scale = Vector2.ONE / texture_scale
