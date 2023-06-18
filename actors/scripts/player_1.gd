extends CharacterBody2D

@export_category("Variables")
@export var _move_speed: float = 64.0

@onready var animation := $anim as AnimatedSprite2D

func _physics_process(delta):
	_move()
	
func _move():
	var _direction: Vector2 = Vector2(
		Input.get_axis("walk_left", "walk_right"),
		Input.get_axis("walk_up", "walk_down")
	)
	
	if _direction != Vector2.ZERO:
		if _direction.x == 1:
			animation.play("walk_right")
		elif _direction.x == -1:
			animation.play("walk_left")
		elif _direction.y == 1:
			animation.play("walk_down")
		else:
			animation.play("walk_up")
			
	else:
		animation.play("idle")
	
	velocity = _direction.normalized() * _move_speed
	move_and_slide()
