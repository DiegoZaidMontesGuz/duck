extends BaseDuck
class_name PinkDuck

var default_speed = 600
var tport =preload("res://scenes/tport.tscn")
var parent
var papa = "papa"
var isThereAWall = false

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	parent = get_parent()
	speed = default_speed
	
func _input(event):
	
	if event is InputEventMouseButton and event.is_pressed() and not is_running and not isThereAWall:
		var instance = tport.instantiate()
		var instance1 = tport.instantiate()
		instance.location = position
		instance.location.x -= 80
		instance.location.y -= 40
		parent.add_child(instance)
		add_child(instance1)
		activate_timer()
		var tportPosition = to_mouse.normalized() * 400
		var tportLen = tportPosition.length()
		if tportLen >= dist:
			position = mouse
		else :
			position = (tportPosition) + global_position
	elif event is InputEventMouseButton and not event.is_pressed():
		speed = default_speed
	if idle == true:
		animated_sprite.play("idle")
	else :
		animated_sprite.play("walking")
	
