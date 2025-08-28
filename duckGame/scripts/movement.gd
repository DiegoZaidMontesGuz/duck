extends CharacterBody2D
class_name  BaseDuck

@export var speed: float = 100
@export var stop_radius: float = 10.0

var to_mouse : Vector2
var dist := 0.0
var mouse : Vector2

var is_running := false
var chargeTime = 3.0


func  _ready():
	
	pass
	
func _process(delta):
	var target := get_global_mouse_position()
	var to_mouse := target - global_position
	rotation = to_mouse.angle()
	pass
	
func activate_timer():
	if is_running:
		return 
	is_running = true
	print("time started")
	start_timer()
	pass
	
func start_timer():
	await get_tree().create_timer(chargeTime).timeout
	print("time finished")
	is_running = false

func _physics_process(_delta: float) -> void:
	mouse = get_global_mouse_position()
	to_mouse = mouse - global_position
	dist = to_mouse.length()

	if dist > stop_radius:
		velocity = to_mouse.normalized() * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()  
