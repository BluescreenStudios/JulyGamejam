extends Node3D
@onready var buttons = $"../ButtonGroup"

@export var objects = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for button in buttons.get_children():
		button.connect("activate", _on_button_activate)
		button.connect("deactivate", _on_button_deactivate)

func _on_button_activate(id):
	if id < objects.size():
		var obj = get_node(objects[id])		
		if obj:
			var animation_player = obj.get_node("AnimationPlayer")
			if animation_player:
				animation_player.play("Activate")
			else:
				print("ANIMATION PLAYER DOESN'T EXIST FOR OBJECT %s" % id)
	else:
		print("OBJECT TO ACTIVATE DOESN'T EXIST FOR BUTTON %s" % id)

func _on_button_deactivate(id):
	if id < objects.size():
		var obj = get_node(objects[id])
		var anim: AnimationPlayer = obj.get_node("AnimationPlayer")
		var seconds_in = anim.current_animation_position
		anim.play_backwards("Activate")
