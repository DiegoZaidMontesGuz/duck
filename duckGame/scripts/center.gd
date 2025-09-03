extends Node2D

var pink = false
var yellow = false
var purple = false

func _ready():
	self.get_parent().get_node("StandingPink/SelectPink").visible = false
	self.get_parent().get_node("StandingDuckYellow/SelectYellow").visible = false
	self.get_parent().get_node("StandingDuckPurple/SelectPurple").visible = false
	pass
	
func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		print("click")
		if yellow:
			Global.yellow = true
			get_tree().change_scene_to_file("res://scenes/main.tscn")
		if purple:
			Global.purple = true
			get_tree().change_scene_to_file("res://scenes/main.tscn")
		if pink:
			Global.pink = true
			get_tree().change_scene_to_file("res://scenes/main.tscn")
			

func _process(delta):
	var target := get_global_mouse_position()
	var to_mouse := target - global_position
	rotation = to_mouse.angle()
	#print(rotation)
	if rotation > -1.6 and rotation < 0.46:
		self.get_parent().get_node("StandingDuckYellow/SelectYellow").visible = true
		yellow = true
	else :
		self.get_parent().get_node("StandingDuckYellow/SelectYellow").visible = false
		yellow = false
	if (rotation < -1.6 and rotation > -3.137) or (rotation < 3.1415 and rotation > 2.6):
		self.get_parent().get_node("StandingDuckPurple/SelectPurple").visible = true
		purple = true
	else :
		self.get_parent().get_node("StandingDuckPurple/SelectPurple").visible = false
		purple = false
	if rotation < 2.6 and rotation > 0.46:
		self.get_parent().get_node("StandingPink/SelectPink").visible = true
		pink = true
	else :
		self.get_parent().get_node("StandingPink/SelectPink").visible = false
		pink = false
	
	
	
