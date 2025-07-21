extends CharacterBody2D

signal on_player_score

@export var JUMP_FORCE: float = 350.0
@export var MAX_FALL_SPEED: float = 500.0
@export var ROCKET_ROTATE_SPEED: float = 1.0

var planet_pivot: Vector2
var rotate_angle: float
var planet_radius: float
var is_player_flying: bool = false

func _ready() -> void:
	is_player_flying = true
	
func _physics_process(delta: float):
	process_gravity(delta)
	process_velocity(delta)
	rotate_around_planet(delta)
	
	# Move the body
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	var collision = body.get_node("CollisionShape2D") as CollisionShape2D
	if collision != null:
		var circleShape = collision.shape as CircleShape2D
		if circleShape != null:
			is_player_flying = false
			
			planet_pivot = body.position
			planet_radius = circleShape.radius
			
			rotate_angle = (global_position - planet_pivot).angle()
			
			on_player_score.emit()

func process_gravity(delta: float) -> void:
	if is_player_flying:
		velocity.y += (MAX_FALL_SPEED * delta)
	
func process_velocity(delta: float) -> void:
	if !is_player_flying:
		velocity = Vector2.ZERO
		if Input.is_action_just_pressed("jump"):
			rotate_angle = 0
			is_player_flying = true
			
			print("JUMP!")
			velocity = Vector2.UP.rotated(rotation) * JUMP_FORCE
			print(velocity)

func rotate_around_planet(delta: float) -> void:
	if is_player_flying:
		return
	if planet_pivot != Vector2.ZERO && planet_radius != 0:
		rotate_angle += ROCKET_ROTATE_SPEED * delta

		var outward = Vector2(cos(rotate_angle), sin(rotate_angle))
		global_position = planet_pivot + outward * planet_radius

		# Align forward (0, -1) with the outward direction
		rotation = outward.angle() + PI / 2
