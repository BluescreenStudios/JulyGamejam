extends StaticBody3D

@onready var animation_player = $AnimationPlayer

func _ready():
	pass
	
func _process(delta):
	pass

func _on_area_3d_body_entered(body):
	animation_player.play("activate")

func _on_area_3d_body_exited(body):
	animation_player.play("deactivate")
