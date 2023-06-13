extends CharacterBody2D

@export_category("Variables")
@export var move_speed: float = 64.0

@onready var animation := $anim as AnimatedSprite2D
#@onready var remote_transform := $remote as RemoteTransform2D
@onready var camera := $camera as Camera2D
signal roll

var direction = Vector2.ZERO

func play_turn():
	
	#remote_transform.align()
	camera.make_current()
	
	
	print("Rode o dado!!!")

	# Espere o jogador rolar o dado
	await roll
	
	var dice = (randi() % 6 + 1)
	print("numero sorteado: ", dice)
	await move(dice) # TODO: mudar para andar em casas específicas
		
	animation.play("idle")
	
	# If casa especial, ????
	
func _physics_process(delta):
	
	velocity = direction.normalized() * move_speed
	move_and_slide()
	
	# Emite se o jogador rolou o dado
	if(Input.is_action_just_pressed("roll_dice")):
		roll.emit()

func move(number):
	
	direction = Vector2.ZERO
	
	if number <= 0:
		return
	
	# TODO: Mudar isso aqui
	if number % 4 == 0:
		direction.x = 1
		animation.play("move_right")
	elif number % 4 == 1:
		direction.y = 1
		animation.play("move_down")
	elif number % 4 == 2:
		direction.x = -1
		animation.play("move_left")
	elif number % 4 == 3:
		direction.y = -1
		animation.play("move_up")
	
	
	await get_tree().create_timer(1.3).timeout

	await move(number - 1)

#func follow_camera(camera, batata):
#	if(batata):
#		var camera_path = camera.get_path()
#		remote_transform.remote_path = camera_path

# TODO:
# Player Rodar o dado
# Mudar a direção (casas específicas)
# Casas especiais
