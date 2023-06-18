extends Node2D

# "Classe" que pega a posição dos tiles no mapa (e vê se são tiles especiais ou não)
# Indices de Tiles especiais: 25, 31, 38, 42, 49, 73, 80, 84, 91
var esp_tiles = [25, 31, 38, 42, 49, 73, 80, 84, 91, -1]
var index_esp = 0

var active_char
var locations = []

func get_locations():
	var n_children = get_child_count()

	var index = 0
	while(index != n_children):
		active_char = get_child(index)
		locations.append({"loc":active_char.position, "special":false})
		if index == esp_tiles[index_esp]:
			locations[index].special = true
			index_esp += 1
		index += 1

	
	return locations
