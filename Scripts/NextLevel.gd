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
		4:
			level = preload("res://Scenes/levels/level_4.tscn")
		5:
			level = preload("res://Scenes/levels/level_5.tscn")
		6:
			level = preload("res://Scenes/levels/level_6.tscn")
		7:
			level = preload("res://Scenes/levels/level_7.tscn")
		8:
			level = preload("res://Scenes/levels/level_8.tscn")
		9:
			level = preload("res://Scenes/levels/level_9.tscn")
		10:
			level = preload("res://Scenes/levels/level_10.tscn")
		11:
			level = preload("res://Scenes/levels/level_11.tscn")
		12:
			level = preload("res://Scenes/levels/level_12.tscn")
		13:
			level = preload("res://Scenes/Levels/level_boss.tscn")

func _process(delta):
	pass
