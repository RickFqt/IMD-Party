extends CharacterBody2D

@export_category("Variables")
@export var move_speed: float = 120.0

@onready var control = get_node("/root/controle")
@onready var animation := $anim as AnimatedSprite2D
#@onready var remote_transform := $remote as RemoteTransform2D
@onready var camera := $camera as Camera2D
var animation_number = 0 # Numero de animacao do player
var curr_position = -1 # INDICE!!!!!!!! do player na lista global de posicoes
var moedas_obrigatorias = 0
var moedas_optativas = 0
var n_diplomas = 0

var able_to_move = false

signal roll # Sinal emitido quando o jogador aperta "ENTER"
signal reached_location # Sinal emitido quando o jogador se move para determinado local
signal reached_star # Sinal emitido quando o jogador passa por uma casa de diploma

var target_location

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
		
	animation.play(str(animation_number) +"_idle")
	
	# Verifica se o jogador terminou em uma Sala de Aula
	if control.locations[curr_position].special:
		animation.play(str(animation_number) +"_idle")
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

func move(number):
	
	if number <= 0:
		return
	
	# Set target location
	if(curr_position != -1 and ((curr_position + 1) % control.locations.size() == 0)):
		# Caso em que o jogador esta no "ultimo" tile do mapa
		target_location = control.locations[5].loc
		# Atualiza a posição atual do jogador
		curr_position = 5
	else:
		target_location = control.locations[(curr_position + 1) % control.locations.size()].loc
		# Atualiza a posição atual do jogador
		curr_position += 1

	# Espere o jogador chegar na casa desejada
	await move_to_location(target_location)
	target_location = position # So por seguranca
	
	# Espera um tico
	await get_tree().create_timer(0.3).timeout
	
	# Verifica se está em uma casa de diploma
	if control.star_location.index == curr_position:
		animation.play(str(animation_number) +"_idle")
		print("olhaii diploma aeeeee")
		# TODO: Verificar se o jogador pode comprar o diploma ou nao
		# TODO: Receber input para o player poder escolher comprar ou nao a estrela
		await get_tree().create_timer(2).timeout
		reached_star.emit()
		

	await move(number - 1)
	
func move_to_location(location):
	able_to_move = true
	if(position.x > location.x + 10):
		animation.play(str(animation_number) + "_move_left")
	elif(position.x + 10 < location.x):
		animation.play(str(animation_number) +"_move_right")
	elif(position.y > location.y + 10):
		animation.play(str(animation_number) +"_move_up")
	else:
		animation.play(str(animation_number) +"_move_down")
	# Espere o jogador chegar na casa desejada
	await reached_location

