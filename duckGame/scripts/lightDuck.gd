extends BaseDuck
class_name YellowDuck

var speed_phase = false
var restore_phase = false

var default_speed = 600

@onready var animated_sprite = $AnimatedSprite2D
@onready var prog_bar = $progress_bar/Bar
@onready var electricity = $electricity/CPUParticles2D

func draning_bar():
	if prog_bar.value != 0:
		prog_bar.value -= 10
	pass
func restore_bar():
	is_running = true
	if prog_bar.value != 1000:
		prog_bar.value += 10
	else : 
		restore_phase = false
		is_running = false
func _ready():
	speed = default_speed
	speed = 600
	
func _process(delta):
	if speed_phase:
		draning_bar()
	if restore_phase:
		restore_bar()
	
func _input(event):
	if event is InputEventMouseButton and not is_running:
		#activate_timer()
		speed_phase = true
		speed *= 5
		electricity.emitting = true
		
	else:
		if speed_phase:
			speed_phase = false
			restore_phase = true
		speed = 600
		electricity.emitting = false
		
	if idle:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("walking")
		
