extends BaseDuck
class_name PinkDuck

var default_speed := 600
@export var default_time = 3
var tport := preload("res://scenes/tport.tscn")
var pBar := preload("res://scenes/progress_bar.tscn")
var parent
var papa := "papa"
var isThereAWall := false
var draining_phase = false
var restore_Phase = false


@onready var animated_sprite := $AnimatedSprite2D
@onready var prog_bar := $progress_bar/Bar

func is_position_in_wall(pos: Vector2) -> bool:
	var space_state := get_world_2d().direct_space_state
	var params := PhysicsPointQueryParameters2D.new()
	params.position = pos
	params.collision_mask = 1 # your wall collision layer
	params.collide_with_bodies = true
	params.collide_with_areas = true
	var intersects := space_state.intersect_point(params)
	return not intersects.is_empty()

func find_landing_within(start: Vector2, dir: Vector2, max_dist: float, step := 8.0) -> Vector2:
	var target := start + dir * max_dist
	if not is_position_in_wall(target):
		return target

	var pos := target
	var backed := 0.0
	while backed <= max_dist and is_position_in_wall(pos):
		pos -= dir * step
		backed += step

	if not is_position_in_wall(pos):
		return pos

	return start

func draining_bar():
	if prog_bar.value != 0:
		prog_bar.value -= 34
	else:
		draining_phase = false
		restore_Phase = true

func restore_bar():
	if prog_bar.value != 1000:
		prog_bar.value += ceil(1000.0 / (60.0 * default_time))
	else :
		restore_Phase = false
	

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Engine.max_fps = 60
	
	parent = get_parent()
	var barInstance = pBar.instantiate()
	speed = default_speed
	chargeTime = default_time
	
	add_to_group("player") 
	

func _process(delta):
	
	if draining_phase:
		draining_bar()
	elif  restore_Phase:
		restore_bar()

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
		var max_teleport_dist := 450.0
		var target_dist = min(dist, max_teleport_dist)

		var landing := find_landing_within(global_position, dir, target_dist, 8.0)

		if landing != global_position:
			global_position = landing
			draining_phase = true

	elif event is InputEventMouseButton and not event.is_pressed():
		speed = default_speed

	if idle:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("walking")
