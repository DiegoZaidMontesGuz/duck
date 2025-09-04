extends CharacterBody2D

@export var speed: float = 700.0
@export var stop_radius: float = 10.0

@onready var agent: NavigationAgent2D = $NavigationAgent2D

var player: Node = null
var idle: bool = false

func _on_player_caught():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")

func _ready() -> void:
	# Find current player (if it already exists)
	
	# Catch players spawned later
	get_tree().node_added.connect(_on_node_added)

	# Agent setup
	agent.path_desired_distance = 8.0
	agent.target_desired_distance = stop_radius
	agent.avoidance_enabled = true

	# If your player script has `class_name BaseDuck`, copy its movement props
	_copy_player_movement_props()

func _on_node_added(n: Node) -> void:
	if player == null and n.is_in_group("player"):
		player = n
		_copy_player_movement_props()

func _try_set_player() -> void:
	player = get_tree().get_first_node_in_group("player")

func _copy_player_movement_props() -> void:
	if player == null:
		return
	# Only copy if it's the expected script type (avoids property errors)
	if player is BaseDuck:
		var bd: BaseDuck = player
		speed = bd.speed
		stop_radius = bd.stop_radius
		agent.target_desired_distance = stop_radius

func _physics_process(_delta: float) -> void:
	_try_set_player()
	
	if player == null:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	agent.target_position = player.global_position

	var to_player: Vector2 = player.global_position - global_position
	if to_player.length() <= stop_radius:
		velocity = Vector2.ZERO
		idle = true
		move_and_slide()
		rotation = to_player.angle()
		return

	idle = false

	# Pathfollow toward the next path point
	var next_point: Vector2 = agent.get_next_path_position()
	var to_point: Vector2 = next_point - global_position

	if to_point.length() > 0.001:
		velocity = to_point.normalized() * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	# Face movement if moving; otherwise face the player
	if velocity.length() > 0.01:
		rotation = velocity.angle()
	else:
		rotation = to_player.angle()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider != null and collider.is_in_group("player"):
			print("papa")
			get_tree().call_deferred("change_scene_to_file", "res://scenes/LooseScreen.tscn")
			break  # Use break to exit the loop after the first collision
