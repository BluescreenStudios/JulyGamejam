extends Node3D
@onready var buttons = $"../ButtonGroup"

@export var objects = []

func _ready():
	for button in buttons.get_children():
		button.connect("activate", _on_button_activate)
		button.connect("deactivate", _on_button_deactivate)

func _on_button_activate(id):
	if id < objects.size():
		var obj: Node3D = get_node(objects[id])
		obj.active = true

func _on_button_deactivate(id):
	if id < objects.size():
		var obj: Node3D = get_node(objects[id])
		obj.active = false

