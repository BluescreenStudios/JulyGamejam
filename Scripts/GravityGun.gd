extends Node

class_name GravityGun

var obj: RigidBody3D
var ray: RayCast3D
var player

func _init(_ray, _player):
	ray = _ray
	player = _player

func handle_fire():
	var result = ray.get_collider()
	if not result is RigidBody3D:
		return
	if not is_instance_valid(obj):
		obj = null
	if obj && obj != result:
		obj.gravity_scale = 1
		
	obj = result
	obj.gravity_scale = -obj.gravity_scale
	obj.sleeping = false
	
	
func handle_alt_fire():
	if player.grounded and Input.is_action_just_pressed("alt_fire"):
		player.gravity = -player.gravity
		player.Just_turned_grav = true
	
