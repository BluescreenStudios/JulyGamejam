extends Node3D

enum GadgetMode { MAGNET, GRAVITY, FREEZERAY, DUPLICATOR }
@onready var animation = $AnimationPlayer
@onready var CurrentMode: GadgetMode = GadgetMode.MAGNET
@onready var ray = $RayCast3D
var physics_moving_object : CollisionObject3D
var distance = 0

func _ready():
	pass # Replace with function body.

func _unhandled_key_input(event: InputEvent):
	handle_gadget_swap(event)
	if event.is_action("fire"):
		handle_gadget_fire(event)
	if event.is_action_pressed("alt_fire"):
		handle_gadget_alt_fire()

func handle_gadget_alt_fire():
	match CurrentMode:
		GadgetMode.MAGNET:
			pass
		GadgetMode.GRAVITY:
			pass
		GadgetMode.FREEZERAY:
			pass
		GadgetMode.DUPLICATOR:
			pass

func handle_gadget_fire(event):
	match CurrentMode:
		GadgetMode.MAGNET:
			handle_magnet_fire(event)
			pass
		GadgetMode.GRAVITY:
			if ray.is_colliding():
				
				pass
		GadgetMode.FREEZERAY:
			pass
		GadgetMode.DUPLICATOR:
			pass
		

func _input(event):
	if event is InputEventMouseMotion and physics_moving_object:
		# Allow to move the object closer or further with the mouse wheel
		if Input.is_action_pressed("scroll_up"):
			distance -= 1 
		elif Input.is_action_pressed("scroll_down"):
			distance += 1  # Move further

func handle_magnet_fire(event):
	if event.is_pressed():
		var screen_middle = get_viewport().size / 2
		var camera = get_viewport().get_camera()
		
		var from = camera.project_ray_origin(screen_middle)
		var to = from + camera.project_ray_normal(screen_middle) * 1000  # Long enough distance
		var space_state = get_world_3d().direct_space_state
		var ray_query = PhysicsRayQueryParameters3D.new()
		ray_query.from = from
		ray_query.to = to
		
		var result = space_state.intersect_ray(ray_query)
		
		if result and result.collider:
			physics_moving_object = result.collider
			distance = from.distance_to(result.position)
		
	if not event.is_pressed() and physics_moving_object:
		physics_moving_object = null

func handle_gadget_swap(event: InputEvent):
	if event.is_released():
		match event.as_text():
			"1":
				CurrentMode = GadgetMode.MAGNET
			"2":
				CurrentMode = GadgetMode.DUPLICATOR
			"3":
				CurrentMode = GadgetMode.FREEZERAY
			"4":
				CurrentMode = GadgetMode.GRAVITY

func switch_out_animation():
	match CurrentMode:
		GadgetMode.MAGNET:
			pass
		GadgetMode.GRAVITY:
			pass
		GadgetMode.FREEZERAY:
			pass
		GadgetMode.DUPLICATOR:
			pass

func switch_into_animation():
	match CurrentMode:
		"pass":
			pass

func _process(delta):
	if physics_moving_object && CurrentMode == GadgetMode.MAGNET:
		var camera = get_viewport().get_camera()
		var screen_middle = get_viewport().size / 2
		var target_position = camera.project_ray_origin(screen_middle) + camera.project_ray_normal(screen_middle) * distance
		
		physics_moving_object.global_transform.interpolate_with(target_position, 0.1)

