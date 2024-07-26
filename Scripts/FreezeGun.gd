extends Node

class_name FreezeGun

var frozen_item: RigidBody3D

var ray: RayCast3D

func _init(_ray):
	ray = _ray

func handle_fire():
	var result = ray.get_collider()
	if not result is RigidBody3D:
		return
	
	if not is_instance_valid(frozen_item):
		frozen_item = null
		
	if frozen_item && frozen_item != result:
		frozen_item.freeze = false
		
	frozen_item = result
	frozen_item.freeze = !frozen_item.freeze
	
	
func handle_release():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
