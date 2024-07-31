extends Node3D

@export var active = false
var opened = false
@onready var anim = $AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active and not opened:
		anim.play("Open", -1, 3.0)
		opened = true
	elif not active and opened:
		anim.play("Open", -1, -3.0)
		opened = false
