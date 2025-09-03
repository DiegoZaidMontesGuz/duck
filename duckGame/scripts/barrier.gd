extends Area2D

var pinkDuck
var counter = 0
var hold = 0
func _ready():
	# Correct way in Godot 4: pass a Callable
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))	
	pinkDuck = get_node_or_null("../../PinkDuck")
	if pinkDuck != null:
		
		print(pinkDuck.papa)
		
func _process(delta):
	#hold = counter
	#print("hold: ")
	#print(hold)
	#print("counter: ")
	#print(counter)
	pass

#
#func _on_input_event(viewport, event, shape_idx):
	#counter = counter + 1
	#pinkDuck.isThereAWall = true
	#if event is InputEventMouseButton and event.pressed:
		#if event.button_index == MOUSE_BUTTON_LEFT:
			#print("You clicked on me!")
			#pinkDuck.isThereAWall = true
	#pinkDuck.isThereAWall = true
			
func _on_mouse_entered():
	if pinkDuck != null:
		pinkDuck.isThereAWall = true
		print("Mouse entered the area")
	
func _on_mouse_exited():
	if pinkDuck != null:
		pinkDuck.isThereAWall = false
		print("Mouse left the area")
