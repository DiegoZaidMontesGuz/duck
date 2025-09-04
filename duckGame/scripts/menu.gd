extends Node2D
@onready var green = $Green

func _on_button_pressed():
	green.visible = true
	get_tree().change_scene_to_file("res://scenes/select.tscn")
	pass # Replace with function body.


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
	pass # Replace with function body.
