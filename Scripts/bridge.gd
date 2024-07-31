extends Node3D

@export var extend_by = 5.5
var current = 0
@export var speed = 3

@export var active = false

func _process(delta):
	var should_extend = extend_by * delta * speed
	if active and current < extend_by:
		position.z += should_extend
		current += should_extend
		if current > extend_by:
			current = extend_by
	elif not active and current > 0:
		position.z -= should_extend
		current -= should_extend
		if current < 0:
			current = 0
