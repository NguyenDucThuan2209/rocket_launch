extends Node

@export var initial_planets_amount: int

@export var row_distance: float
@export var camera_offset: Vector2
@export var planet_spawn_offset: Vector2
@export var player_spawn_position: Vector2

@export var camera: Camera2D
@export var player: PackedScene
@export var planets: Array[PackedScene]

var score: int = 0
var direction: float = 1
var current_column: float = 1
var current_height: float = 0
var column_distance: float = 0

func _ready() -> void:
	# Reset score
	score = 0
		
	# Calculate the column distance
	column_distance = camera.get_viewport_rect().size.x / 3
	
	# Calculate the player spawn horizontally
	player_spawn_position.x = camera.get_viewport_rect().size.x / 2
	
	# Spawn the player
	spawn_player()
	
	# Spawn the initial planets
	for i in initial_planets_amount: 
		spawn_planet()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		var key = event as InputEventKey
		if key.keycode == KEY_UP:
			camera.position -= Vector2(0, 100)
		if key.keycode == KEY_DOWN: 
			camera.position += Vector2(0, 100)

func spawn_player() -> void:
	var instance = player.instantiate()
	instance.position = player_spawn_position
	instance.on_player_score.connect(update_player_score.bind())
	add_child(instance)
	

func spawn_planet() -> void:
	if planets.is_empty():
		return
	
	# Get a random planet instance
	var planet = planets[randi() % planets.size()]
	var instance = planet.instantiate()

	# Calculate spawn position
	var x = current_column * column_distance + planet_spawn_offset.x
	var y = current_height + planet_spawn_offset.y

	# Set the planet position and parent
	instance.position = Vector2(x, y)
	$PlanetHolder.add_child(instance)

	# Update height for the next spawn
	current_height -= row_distance 

	# Move to next column to prepare for the next spawn
	current_column += direction
	if current_column >= 3:
		current_column = 1
		direction = -1
	elif current_column < 0:
		current_column = 1
		direction = 1

func update_player_score() -> void:
	score += 1
	print("Score: ", score)
	pass
