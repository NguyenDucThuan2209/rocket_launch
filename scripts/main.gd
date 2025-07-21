extends Node

@export var row_distance: float
@export var spawn_offset: Vector2
@export var camera_offset: Vector2

@export var camera: Camera2D
@export var planet_holder: Node2D
@export var player: PackedScene
@export var planets: Array[PackedScene]

var direction: float = 1
var current_column: float = 1
var current_height: float = 0
var column_distance: float = 0

func _ready() -> void:
	var screen_size = camera.get_viewport_rect().size
	column_distance = screen_size.x / 3
	
	for i in 10: 
		spawn_planet()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		var key = event as InputEventKey
		if key.keycode == KEY_UP:
			camera.position -= Vector2(0, 100)
		if key.keycode == KEY_DOWN: 
			camera.position += Vector2(0, 100)

func spawn_player() -> void:
	pass

func spawn_planet() -> void:
	if planets.is_empty():
		return

	var planet = planets[randi() % planets.size()]
	var instance = planet.instantiate()

	# Calculate spawn position
	var x = current_column * column_distance + spawn_offset.x
	var y = current_height + spawn_offset.y

	instance.position = Vector2(x, y)
	planet_holder.add_child(instance)

	# Update height for this column
	current_height -= row_distance 

	# Move to next column
	current_column += direction
	if current_column >= 3:
		current_column = 1
		direction = -1
	elif current_column < 0:
		current_column = 1
		direction = 1
