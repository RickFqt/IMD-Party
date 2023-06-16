extends CharacterBody2D

@export_category("Variables")
@export var move_speed: float = 120.0

@onready var control = get_node("/root/controle")
@onready var animation := $anim as AnimatedSprite2D
#@onready var remote_transform := $remote as RemoteTransform2D
@onready var camera := $camera as Camera2D
var player_number = 0
#var list_positions = [Vector2(0,100), Vector2(0,200), Vector2(100,200), Vector2(100,100), Vector2(100,0), Vector2(0,0)]
var curr_position = 0
var moedas_obrigatorias = 0
var moedas_optativas = 0
var n_diplomas = 0

var able_to_move = false

signal roll
signal reached_location

var target_location

func play_turn():
	
	camera.make_current()
	
	
	print("Rode o dado!!!")

	# Espere o jogador rolar o dado
	await roll
	
	var dice = (randi() % 6 + 1)
	print("numero sorteado: ", dice)
	await move(dice)
		
	animation.play(str(player_number) +"_idle")
	
	# If casa especial, ????
	# If casa de diploma
	# 	If(comprar_diploma)
	#		moedas_obrigatorias -= blau, moedas_optativas -= blei
	#		n_diplomas += 1
	# 		Colocar a casa do diploma em outro lugar do mapa
	# Elif sala de aula
	#	if(professor_na_sala)
	##		mini_game_bonus()
	
	
func _physics_process(delta):
	
	if(able_to_move):
		velocity = position.direction_to(target_location) * move_speed
		
		if position.distance_to(target_location) > 2:
			move_and_slide()
		else:
			# Emite se o jogador chegou no local desejado
			reached_location.emit()
			able_to_move = false
	
	# Emite se o jogador rolou o dado
	if(Input.is_action_just_pressed("roll_dice")):
		roll.emit()

func move(number):
	
	if number <= 0:
		return
	
	# Set target location
	target_location = control.locations[(curr_position + 1) % control.locations.size()]

	# Espere o jogador chegar na casa desejada
	await move_to_location(target_location)
	
	# Atualiza a posição atual do jogador
	target_location = position
	curr_position += 1
	
	# Espera um tico
	await get_tree().create_timer(0.3).timeout

	await move(number - 1)
	
func move_to_location(location):
	able_to_move = true
	if(position.x > location.x + 10):
		animation.play(str(player_number) + "_move_left")
	elif(position.x + 10 < location.x):
		animation.play(str(player_number) +"_move_right")
	elif(position.y > location.y + 10):
		animation.play(str(player_number) +"_move_up")
	else:
		animation.play(str(player_number) +"_move_down")
	# Espere o jogador chegar na casa desejada
	await reached_location

#func follow_camera(camera, batata):
#	if(batata):
#		var camera_path = camera.get_path()
#		remote_transform.remote_path = camera_path

# TODO:
# Player Rodar o dado
# Mudar a direção (casas específicas)
# Casas especiais
