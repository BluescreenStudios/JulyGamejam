extends StaticBody3D

@onready var animation_player = $AnimationPlayer

@export var my_id = 0

signal activate(id)
signal deactivate(id)

func _ready():
	pass
	
func _process(delta):
	pass

func _on_area_3d_body_entered(body):	
	animation_player.play("activate")
	activate.emit(my_id)

func _on_area_3d_body_exited(body):
	animation_player.play_backwards("activate")
	deactivate.emit(my_id)
