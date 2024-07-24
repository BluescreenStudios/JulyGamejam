extends Node3D

enum GadgetMode { MAGNET, GRAVITY, FREEZERAY, DUPLICATOR }
@onready var animation = $AnimationPlayer
@onready var CurrentMode: GadgetMode = GadgetMode.MAGNET
@onready var ray: RayCast3D = $RayCast3D
@onready var camera = $"../Camera3D"
@onready var magnet_gun = MagnetGun.new(ray, camera)

func _ready():
	add_child(magnet_gun)

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

func handle_gadget_fire():
	match CurrentMode:
		GadgetMode.MAGNET:
			magnet_gun.handle_fire()
		GadgetMode.GRAVITY:
			if ray.is_colliding():
				pass
		GadgetMode.FREEZERAY:
			pass
		GadgetMode.DUPLICATOR:
			pass


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
	if Input.is_action_pressed("fire"):
		handle_gadget_fire()
	if Input.is_action_just_released("fire"):
		magnet_gun.handle_release()
	if Input.is_action_pressed("alt_fire"):
		handle_gadget_alt_fire()
		
	var camera_transform = camera.global_transform
	ray.global_transform = camera_transform
	ray.target_position = Vector3(0, 0, -4000)

