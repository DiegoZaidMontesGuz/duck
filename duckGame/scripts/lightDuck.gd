extends BaseDuck
class_name YellowDuck

func _ready():
	speed = 600

func _process(delta):
	
	pass

func _input(event):
	if event is InputEventMouseButton and not is_running:
		activate_timer()
		speed *= 5
	else:
		speed = 600
