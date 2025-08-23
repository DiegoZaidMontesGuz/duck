extends Sprite2D
var mouse_screen
var mouse_world
#func _process(de):
	#var mouse_screen := get_viewport().get_mouse_position()  # pixels in the viewport
	#var mouse_world  := get_global_mouse_position()          # world coords (respects Camera2D)
	## use mouse_screen or mouse_world as needed
func _process(delta):
	mouse_screen = get_viewport().get_mouse_position()  # pixels in the viewport
	mouse_world  = get_global_mouse_position()  
	
	print(slope(position, mouse_screen))
	print(mouse_screen)
	
func movevemrnt():
	
	
	pass

func slope(punto1, punto2) -> float:
	var slope = (punto2.x - punto1.x) / (punto2.y - punto1.y)
	return slope
	
