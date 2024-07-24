extends Area3D

@onready var timer = $Timer

func _on_body_entered(body):
	print("You died!")
	get_tree().reload_current_scene()
