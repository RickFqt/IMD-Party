extends CharacterBody2D

@export_category("Variables")
@export var _move_speed: float = 64.0

@onready var animation := $anim as AnimatedSprite2D

func _physics_process(delta):
	_move()
	
func _move():
	var _direction: Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	
	if _direction != Vector2.ZERO:
		if _direction.x == 1:
			animation.play("move_right")
		elif _direction.x == -1:
			animation.play("move_left")
		elif _direction.y == 1:
			animation.play("move_down")
		else:
			animation.play("move_up")
			
	else:
		animation.play("idle")
	
	velocity = _direction.normalized() * _move_speed
	move_and_slide()
