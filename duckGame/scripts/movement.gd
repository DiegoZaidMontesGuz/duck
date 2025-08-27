extends CharacterBody2D
class_name  BaseDuck

@export var speed: float = 600.0
@export var stop_radius: float = 10.0

func _physics_process(_delta: float) -> void:
	var target: Vector2 = get_global_mouse_position()
	var to_target: Vector2 = target - global_position
	var dist := to_target.length()

	if dist > stop_radius:
		velocity = to_target.normalized() * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()  # handles collision response with walls
