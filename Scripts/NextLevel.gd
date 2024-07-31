extends Node3D

@export var current_level = 0

var level

func _on_body_entered(body):
	if body is CharacterBody3D:
		next_level()


func next_level():
	
	get_tree().change_scene_to_packed(level)


func _ready():
	match current_level + 1:
		1:
			level = preload("res://Scenes/levels/level_1.tscn")
		2:
			level = preload("res://Scenes/levels/level_2.tscn")
		3:
			level = preload("res://Scenes/levels/level_3.tscn")

func _process(delta):
	pass
