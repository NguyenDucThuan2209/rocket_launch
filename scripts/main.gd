extends Node

@export var rowDistance: float
@export var spawnOffset: Vector2

@export var camera: Camera2D
@export var planetHolder: Node2D
@export var planets: Array[PackedScene]

var direction: float = 1
var currentColumn: float = 0
var currentHeight: float = 0
var columnDistance: float = 0

func _ready() -> void:
	var screen_size = camera.get_viewport_rect().size
	columnDistance = screen_size.x / 3
	
	print(screen_size)
	print(columnDistance)
	
	for i in 10: 
		spawn_planet()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		var key = event as InputEventKey
		if key.keycode == KEY_UP:
			camera.position -= Vector2(0, 100)
		if key.keycode == KEY_DOWN: 
			camera.position += Vector2(0, 100)

func spawn_planet() -> void:
	if planets.is_empty():
		return

	var scene = planets[randi() % planets.size()]
	var instance = scene.instantiate()

	# Calculate spawn position
	var x = currentColumn * columnDistance + spawnOffset.x
	var y = currentHeight + spawnOffset.y

	instance.position = Vector2(x, y)
	add_child(instance)

	# Update height for this column
	currentHeight -= rowDistance 

	# Move to next column
	currentColumn += direction
	if currentColumn >= 3:
		currentColumn = 1
		direction = -1
	elif currentColumn < 0:
		currentColumn = 1
		direction = 1
