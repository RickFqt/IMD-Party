extends CharacterBody2D

# @onready variables
@onready var global = get_node("/root/Global")
@onready var camera := $camera as Camera2D
@onready var dice := $dice as Node2D
@onready var diploma = $compraDiploma
@onready var salaDeAula = $salaDeAula

# Variables
var comprar = false
var n_diplomas = 0
var target_location
var curr_player = 1
var move_speed = 120.0
var curr_position = -1 # INDICE!!!!!!!! do player na lista global de posicoes
var moedas_optativas = 0
var able_to_move = false
var moedas_obrigatorias = 0
var animation : AnimatedSprite2D = null

# Signals received
signal endBuyTurn
signal endClassTurn
signal press_enter # Sinal emitido quando o jogador aperta "ENTER"
signal reached_star # Sinal emitido quando o jogador passa por uma casa de diploma
signal reached_location # Sinal emitido quando o jogador se move para determinado local


# Cria o node de animação para o player, baseado em seu número (1 para player1 ou 2 para player 2)
func initialize_animation(n_player):
	if n_player == 1:
		animation = load(Global.player1Dir).instantiate()
	else:
		animation = load(Global.player2Dir).instantiate()
	add_child(animation)

	animation.play("Idle")
	curr_player = n_player

# Função para jogar
func play_turn():
	
	camera.make_current()
	
	# TODO: Fazer o dado aparecer
	print("Rode o dado!!!")
	dice.visible = true

	# Espere o jogador rolar o dado
	await press_enter
	
	dice.roll()
	
	await get_tree().create_timer(0.4).timeout
	
	# TODO: Fazer o dado mostrar o numero sorteado
	
	var n_dice = dice.get_rolled_number()
	print("numero sorteado: ", n_dice)
	
	await get_tree().create_timer(1).timeout
	
	dice.visible = false
	await move(n_dice)
		
	animation.play("Idle")
	
	# Verifica se o jogador terminou em uma Sala de Aula
	if global.locations[curr_position].special:
		await process_class()
	
	
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
		press_enter.emit()

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
		animation.play("Idle")
		print("olhaii diploma aeeeee")
		await process_star()

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

# Função chamada quando um jogador passa por uma casa de diploma
func process_star():
	if moedas_obrigatorias >= global.star_price.ob and moedas_optativas >= global.star_price.ob:
		print("Voce quer comprar um diploma???")
		diploma.visible = true
		animation.visible = false
		await endBuyTurn
		animation.visible = true		
		# TODO: Receber input para o player poder escolher comprar ou nao a estrela
		if comprar:
			moedas_obrigatorias -= global.star_price.ob
			moedas_optativas -= global.star_price.ob
			n_diplomas += 1
			comprar = false
		print("Aeeee comprou o diploma!!!")
	else:
		print("Sem moedas o suficiente :(")
	
	reached_star.emit()

# Função chamada quando um jogador para em frente a uma sala de aula
func process_class():
	
	salaDeAula.visible = true
	animation.visible = false
	moedas_optativas += await salaDeAula.processClass(curr_player)
	animation.visible = true
	
	


func _on_compra_diploma_buy():
	comprar = true


func _on_compra_diploma_end_buy_turn():
	endBuyTurn.emit()

