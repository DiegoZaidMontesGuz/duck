extends Node2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass
func _on_button_pressed():
	Global.pink = false
	Global.purple = false
	Global.yellow = false
	
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	pass # Replace with function body.


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	pass # Replace with function body.
