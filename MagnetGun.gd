extends Node3D

class_name MagnetGun

var physics_moving_object : RigidBody3D = null
var distance = 0.0
var previous_position = Vector3()
var pull_towards_obj
var previous_grav_value

@onready var ray : RayCast3D
@onready var camera : Camera3D
var player

func _init(_ray: RayCast3D, _camera: Camera3D, _player):
	print(player)
	ray = _ray
	camera = _camera
	player = _player
	
func handle_alt_fire():
	if ray.is_colliding() or pull_towards_obj:
		if not pull_towards_obj:
			player.being_pulled = true
			pull_towards_obj = ray.get_collider()
		if not pull_towards_obj:
			player.being_pulled = false
			return
		var target_position = pull_towards_obj.global_transform.origin
		var difference = target_position - player.global_transform.origin
		var direction = difference.normalized()
		var distance = player.global_transform.origin.distance_to(target_position)
		if difference.y < 2:
			difference.y = 0
		if difference.x < 2:
			difference.x = 0
		if difference.z < 2:
			difference.z = 0
			
		var pull_speed = 10.0
		if distance > 1.5:
			player.velocity = direction * pull_speed
			player.move_and_slide()

func handle_fire():
	if ray.is_colliding():
		var screen_middle = get_viewport().size / 2
		var from = camera.project_ray_origin(screen_middle)
		var to = from + camera.project_ray_normal(screen_middle) * 1000
		
		var result = ray.get_collider()
		if result is StaticBody3D:
			return
		if result is RigidBody3D && not result.freeze:
			var first_time_pickup = false
			if not physics_moving_object:
				distance = from.distance_to(result.global_transform.origin)
				first_time_pickup = true
			
			if physics_moving_object != null && physics_moving_object != result:
				return
			physics_moving_object = result
			
			if first_time_pickup:
				previous_grav_value = physics_moving_object.gravity_scale
				physics_moving_object.rotation.x = 0
				physics_moving_object.rotation.y = 0
				physics_moving_object.rotation.z = 0
				
			physics_moving_object.gravity_scale = 0.0

func handle_release():
	if physics_moving_object:
		var velocity = (physics_moving_object.global_transform.origin - previous_position) / get_process_delta_time() * 0.25
		physics_moving_object.linear_velocity = velocity
		physics_moving_object.gravity_scale = previous_grav_value
		physics_moving_object = null
		
func handle_alt_release():
	player.being_pulled = false
	pull_towards_obj = null

func _process(delta):
	if physics_moving_object:
		if Input.is_action_just_pressed("scroll_down"):
			distance -= 1 
		elif Input.is_action_just_pressed("scroll_up"):
			distance += 1
		if distance > 8:
			distance = 8
			
		if physics_moving_object.global_transform.origin.y + 1 < player.global_transform.origin.y:
			if distance < 2.5:
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




