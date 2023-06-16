extends Node2D

var index
var n_children
var active_char
var locations = []

func get_locations():
	n_children = get_child_count()

	index = 0
	while(index != n_children):
		active_char = get_child(index)
		locations.append(active_char.position)
		index += 1
	
	return locations
