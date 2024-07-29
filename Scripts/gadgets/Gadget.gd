extends Node3D

enum GadgetMode { MAGNET, GRAVITY, FREEZERAY, DUPLICATOR }

@onready var animation = $AnimationPlayer
@onready var CurrentMode: GadgetMode = GadgetMode.MAGNET
@onready var ray: RayCast3D = $RayCast3D
@onready var camera = $"../Camera3D"
var player
var level

var magnet_gun: MagnetGun
var grav_gun: GravityGun
var freeze_gun: FreezeGun
var Duper: Duplicator

func _ready():
	player = $".."
	level = player.level
	magnet_gun = MagnetGun.new(ray, camera, player)
	freeze_gun = FreezeGun.new(ray)
	grav_gun = GravityGun.new(ray, player)
	Duper = Duplicator.new(ray)
	add_child(freeze_gun)
	add_child(magnet_gun)
	add_child(grav_gun)
	add_child(Duper)

func handle_gadget_alt_fire():
	match CurrentMode:
		GadgetMode.MAGNET:
			magnet_gun.handle_alt_fire()
		GadgetMode.GRAVITY:
			grav_gun.handle_alt_fire()

func handle_gadget_fire():
	match CurrentMode:
		GadgetMode.MAGNET:
			magnet_gun.handle_fire()
		GadgetMode.GRAVITY:
			if Input.is_action_just_pressed("fire"):
				grav_gun.handle_fire()
		GadgetMode.FREEZERAY:
			if Input.is_action_just_pressed("fire"):
				freeze_gun.handle_fire()
		GadgetMode.DUPLICATOR:
			if Input.is_action_just_pressed("fire"):
				Duper.handle_fire()


func handle_gadget_swap(event: InputEvent):
	if event.is_released():
		match event.as_text():
			"1":
				CurrentMode = GadgetMode.MAGNET
			"2":
				if level > 2:
					CurrentMode = GadgetMode.DUPLICATOR
			"3":
				if level > 4:
					CurrentMode = GadgetMode.FREEZERAY
			"4":
				if level > 7:
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

func _input(event):
	handle_gadget_swap(event)

func _process(delta):
	if Input.is_action_pressed("fire"):
		magnet_gun.handle_alt_release()
		handle_gadget_fire()
	elif Input.is_action_pressed("alt_fire"):
		handle_gadget_alt_fire()
		magnet_gun.handle_release()
	if Input.is_action_just_released("fire"):
		magnet_gun.handle_release()
	if Input.is_action_just_released("alt_fire"):
		magnet_gun.handle_alt_release()
		
	var camera_transform = camera.global_transform
	ray.global_transform = camera_transform
	ray.target_position = Vector3(0, 0, -4000)

