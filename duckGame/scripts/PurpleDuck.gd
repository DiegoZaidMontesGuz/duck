extends BaseDuck
class_name PurpleDuck

var default_speed = 600
var is_long_timer = false
var is_short_timer = false
func _ready():
	speed = default_speed

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() :
		speed = default_speed * 5
	elif event is InputEventMouseButton and not event.is_pressed():
		
		speed = default_speed
