extends Node3D

@export var active = false
@onready var anim = $Platform/AnimationPlayer



func _process(delta):
	if active:
		anim.play("activate")
	else:
		anim.play_backwards("activate")
