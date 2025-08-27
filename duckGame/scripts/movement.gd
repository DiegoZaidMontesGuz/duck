extends CharacterBody2D
class_name  BaseDuck

@export var speed: float = 100
@export var stop_radius: float = 10.0
var to_mouse : Vector2
var dist := 0.0
var mouse : Vector2
func _physics_process(_delta: float) -> void:
	mouse = get_global_mouse_position()
	to_mouse = mouse - global_position
	dist = to_mouse.length()

	if dist > stop_radius:
		velocity = to_mouse.normalized() * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()  
