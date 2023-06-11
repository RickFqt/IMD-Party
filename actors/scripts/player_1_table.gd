extends CharacterBody2D

@export_category("Variables")
@export var _move_speed: float = 64.0
@export var is_turn: bool = false

@onready var animation := $anim as AnimatedSprite2D

var direction = Vector2.ZERO

func play_turn():
	
	#roll dice
	await move(4)
	
func _physics_process(delta):
	velocity = direction.normalized() * _move_speed
	move_and_slide()

func move(number):
	
	direction = Vector2.ZERO
	
	if number == 4:
		direction.x = 1
	elif number == 3:
		direction.y = 1
	elif number == 2:
		direction.x = -1
	elif number == 1:
		direction.y = -1
	
	
	print("batata 1")
	await get_tree().create_timer(2.0).timeout
	
	if(number > 0):
		await move(number - 1)
