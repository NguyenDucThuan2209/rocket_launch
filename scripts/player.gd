extends CharacterBody2D

# Constants
@export var JUMP_FORCE = -250.0
@export var MAX_FALL_SPEED = 200.0

# Velocity
var target_velocity: Vector2 = Vector2.ZERO

func _physics_process(delta):
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			target_velocity.y = JUMP_FORCE
			print("JUMP!")
	else:
		target_velocity.y = target_velocity.y + (MAX_FALL_SPEED * delta)

	# Move the body
	velocity = target_velocity
	move_and_slide()
