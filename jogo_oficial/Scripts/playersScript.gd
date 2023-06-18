extends CharacterBody2D



# @onready variables
@onready var global = get_node("/root/Global")
@onready var animation := $anim as AnimatedSprite2D
@onready var camera := $camera as Camera2D

# Variables
var n_diplomas = 0
var target_location
var move_speed = 120.0
var curr_position = -1 # INDICE!!!!!!!! do player na lista global de posicoes
var moedas_optativas = 0
var able_to_move = false
var moedas_obrigatorias = 0

# Signals received
signal roll # Sinal emitido quando o jogador aperta "ENTER"
signal reached_star # Sinal emitido quando o jogador passa por uma casa de diploma
signal reached_location # Sinal emitido quando o jogador se move para determinado local

# Função para jogar
func play_turn():
	
	camera.make_current()
	
	# TODO: Fazer o dado aparecer
	print("Rode o dado!!!")

	# Espere o jogador rolar o dado
	await roll
	
	# TODO: Fazer o dado mostrar o numero sorteado
	
	var dice = (randi() % 6 + 1)
	print("numero sorteado: ", dice)
	await move(dice)
		
	animation.play("idle")
	
	# Verifica se o jogador terminou em uma Sala de Aula
	if global.locations[curr_position].special:
		animation.play("idle")
		print("olhaii sala de aula aeeeee")
		# TODO: Randomizar se vai ter professor na sala ou nao
		# TODO: Ir para o minigame bonus
		await get_tree().create_timer(2).timeout
	
	
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

# Função para se mover
func move(number):
	
	if number <= 0:
		return
	
	# Set target location
	if(curr_position != -1 and ((curr_position + 1) % global.locations.size() == 0)):
		# Caso em que o jogador esta no "ultimo" tile do mapa
		target_location = global.locations[5].loc
		# Atualiza a posição atual do jogador
		curr_position = 5
	else:
		target_location = global.locations[(curr_position + 1) % global.locations.size()].loc
		# Atualiza a posição atual do jogador
		curr_position += 1

	# Espere o jogador chegar na casa desejada
	await move_to_location(target_location)
	target_location = position # So por seguranca
	
	# Espera um tico
	await get_tree().create_timer(0.3).timeout
	
	# Verifica se está em uma casa de diploma
	if global.star_location.index == curr_position:
		animation.play("idle")
		print("olhaii diploma aeeeee")
		# TODO: Verificar se o jogador pode comprar o diploma ou nao
		# TODO: Receber input para o player poder escolher comprar ou nao a estrela
		await get_tree().create_timer(2).timeout
		reached_star.emit()
		

	await move(number - 1)
	
func move_to_location(location):
	able_to_move = true
	if(position.x > location.x + 10):
		animation.play("walk_left")
	elif(position.x + 10 < location.x):
		animation.play("walk_right")
	elif(position.y > location.y + 10):
		animation.play("walk_up")
	else:
		animation.play("walk_down")
	# Espere o jogador chegar na casa desejada
	await reached_location

