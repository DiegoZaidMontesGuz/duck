extends BaseDuck
class_name PurpleDuck

var default_speed = 600
var is_long_timer = false
var is_short_timer = false

var speed_phase = false
var restore_phase = false

@onready var animated_sprite := $AnimatedSprite2D
@onready var prog_bar = $progress_bar/Bar
@onready var particles = $purple/CPUParticles2D

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
	if event is InputEventMouseButton and event.is_pressed() and not is_running :
		speed = default_speed * 5
		speed_phase = true
		particles.emitting = true
	elif event is InputEventMouseButton and not event.is_pressed():
		particles.emitting = false
		if speed_phase:
			speed_phase = false
			restore_phase = true
		speed = default_speed
	
	if idle:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("walking")
