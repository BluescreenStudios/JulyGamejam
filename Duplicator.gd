extends Node

class_name Duplicator

var orig
var dupe
var ray

func _init(_ray):
	ray = _ray

func handle_fire():
	var result = ray.get_collider()
	if not result is RigidBody3D:
		return
	if result == dupe:
		return

	if dupe:
		dupe.free()
		
	duplicate_object(result)

func duplicate_object(original: RigidBody3D):
	var new_instance = original.duplicate()
	var world = original.get_parent()
	world.add_child(new_instance)
	new_instance.global_transform = original.global_transform
	new_instance.name = original.name + "_duplicate"
	orig = original
	dupe = new_instance
	dupe.freeze = false
