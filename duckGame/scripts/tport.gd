extends AnimatedSprite2D
class_name Tport

var is_running = false
var location = Vector2(0,0)

func _ready():
	activate_timer()
	position = location


func activate_timer():
	if is_running:
		return 
	is_running = true
	#print("time started")
	start_timer()
	pass
	
func start_timer():
	await get_tree().create_timer(3.0).timeout
	print("time finished")
	is_running = false
	queue_free()
