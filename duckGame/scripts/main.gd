extends Node2D

var pinkDuck := preload("res://scenes/pink_duck.tscn")
var yellowDuck := preload("res://scenes/yellow_duck.tscn")
var purpleDuck := preload("res://scenes/purple_duck.tscn")

func _ready():
	if Global.yellow:
		var instance = yellowDuck.instantiate()
		add_child(instance)
	if Global.pink:
		var instance = pinkDuck.instantiate()
		add_child(instance)
	if Global.purple:
		var instance = purpleDuck.instantiate()
		add_child(instance)
