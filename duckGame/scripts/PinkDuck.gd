extends BaseDuck
class_name PinkDuck

var default_speed := 600
var tport := preload("res://scenes/tport.tscn")
var pBar := preload("res://scenes/progress_bar.tscn")
var parent
var papa := "papa"
var isThereAWall := false

@onready var animated_sprite := $AnimatedSprite2D

func is_position_in_wall(pos: Vector2) -> bool:
	var space_state := get_world_2d().direct_space_state
	var params := PhysicsPointQueryParameters2D.new()
	params.position = pos
	params.collision_mask = 1 # your wall collision layer
	params.collide_with_bodies = true
	params.collide_with_areas = true
	var intersects := space_state.intersect_point(params)
	return not intersects.is_empty()

# Find a valid landing point that is <= max_dist from 'start'.
# We try the farthest allowed point first, then step BACK toward the start
# so we never exceed the distance cap.
func find_landing_within(start: Vector2, dir: Vector2, max_dist: float, step := 8.0) -> Vector2:
	var target := start + dir * max_dist
	# If target is free, take it.
	if not is_position_in_wall(target):
		return target

	# Otherwise, back up toward the start (still within max_dist).
	var pos := target
	var backed := 0.0
	while backed <= max_dist and is_position_in_wall(pos):
		pos -= dir * step
		backed += step

	# If we exited the wall, pos is guaranteed <= max_dist from start.
	if not is_position_in_wall(pos):
		return pos

	# Couldn't find a free spot within the distance cap.
	return start

func _ready():
	parent = get_parent()
	var barInstance = pBar.instantiate()
	parent.add_child(barInstance)
	speed = default_speed

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and not is_running:
		# FX
		var instance = tport.instantiate()
		var instance1 = tport.instantiate()
		instance.location = position
		instance.location.x -= 80
		instance.location.y -= 40
		parent.add_child(instance)
		add_child(instance1)
		activate_timer()

		# Direction and hard cap
		var dir := to_mouse.normalized()
		var max_teleport_dist := 600.0
		var target_dist = min(dist, max_teleport_dist)

		# Compute landing strictly within the cap; allows passing through walls.
		var landing := find_landing_within(global_position, dir, target_dist, 8.0)

		# Only move if we actually found something different than start.
		if landing != global_position:
			global_position = landing
		# else: stay put (e.g., entire range is solid)

	elif event is InputEventMouseButton and not event.is_pressed():
		speed = default_speed

	if idle:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("walking")
