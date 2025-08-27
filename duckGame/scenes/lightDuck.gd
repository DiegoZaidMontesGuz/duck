extends BaseDuck
class_name YellowDuck

func _ready():
	speed = 600

func _process(delta):
	
	pass

func _input(event):
	if event is InputEventMouseButton:
		speed *= 5
	else:
		speed = 600
