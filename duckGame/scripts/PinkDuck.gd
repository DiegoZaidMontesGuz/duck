extends BaseDuck
class_name PinkDuck

var default_speed = 600

func _ready():
	
	speed = default_speed
	
func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		var tportPosition = to_mouse.normalized() * 400
		var tportLen = tportPosition.length()
		if tportLen >= dist:
			position = mouse
		else :
			position = (tportPosition) + global_position
	elif event is InputEventMouseButton and not event.is_pressed():
		speed = default_speed
