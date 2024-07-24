extends Node3D

class_name MagnetGun
@onready var player = $"."
var physics_moving_object : RigidBody3D = null
var distance = 0.0
var previous_position = Vector3()
@onready var ray : RayCast3D
@onready var camera : Camera3D

func _init(_ray: RayCast3D, _camera: Camera3D):
	ray = _ray
	camera = _camera

func handle_fire():
	if ray.is_colliding():
		var screen_middle = get_viewport().size / 2
		var from = camera.project_ray_origin(screen_middle)
		var to = from + camera.project_ray_normal(screen_middle) * 1000
		var result = ray.get_collider()
		
		if result:
			var first_time_pickup = false
			if not physics_moving_object:
				distance = from.distance_to(result.global_transform.origin)
				first_time_pickup = true
			
			physics_moving_object = result
			physics_moving_object.gravity_scale = 0.0
			if first_time_pickup:
				physics_moving_object.rotation.x = 0
				physics_moving_object.rotation.y = 0
				physics_moving_object.rotation.z = 0

func handle_release():
	if physics_moving_object:
		var velocity = (physics_moving_object.global_transform.origin - previous_position) / get_process_delta_time() * 0.25
		physics_moving_object.linear_velocity = velocity
		physics_moving_object.gravity_scale = 1.0
		physics_moving_object = null
		
func _process(delta):
	if physics_moving_object:
		if Input.is_action_just_pressed("scroll_down"):
			distance -= 1 
		elif Input.is_action_just_pressed("scroll_up"):
			distance += 1
			
		if physics_moving_object.global_transform.origin.y + 1 < player.global_transform.origin.y:
			if distance < 2.5:  # Adjust this value as needed
				distance = 2.5
		else:
			if distance < 1.5:
				distance = 1.5
				
		physics_moving_object.look_at(player.global_transform.origin, Vector3.UP)
		var screen_middle = get_viewport().size / 2
		var target_position = camera.project_ray_origin(screen_middle) + camera.project_ray_normal(screen_middle) * distance
		var target_transform = Transform3D(physics_moving_object.global_transform.basis, target_position)
		var new_transform = physics_moving_object.global_transform.interpolate_with(target_transform, 0.1)
		var motion = new_transform.origin - physics_moving_object.global_transform.origin

		previous_position = physics_moving_object.global_transform.origin
		
		physics_moving_object.position += motion
		
		physics_moving_object.move_and_collide(motion)




