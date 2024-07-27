extends Area3D

var current_spawn = 0
var spawn_points = []

func _on_body_entered(body):
	if body is CharacterBody3D:
		var spawn_point = spawn_points[current_spawn]
