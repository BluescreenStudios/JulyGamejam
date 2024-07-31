extends Node

@export var object:NodePath
@export var button1:NodePath
@export var button2:NodePath

var btn1pressed = false
var btn2pressed = false

func _ready():
	var btn1 = get_node(button1)
	var btn2 = get_node(button2)
	
	btn1.connect("activate", _on_button_activate)
	btn1.connect("deactivate", _on_button_deactivate)
	
	
	btn2.connect("activate", _on_button2_activate)
	btn2.connect("deactivate", _on_button2_deactivate)

func _process(delta):
	if btn1pressed and btn2pressed:
		get_node(object).active = true
	else:
		get_node(object).active = false
	
func _on_button_activate(id):
	btn1pressed = true
	
func _on_button_deactivate(id):
	btn1pressed = false
	
func _on_button2_activate(id):
	btn2pressed = true
	
func _on_button2_deactivate(id):
	btn2pressed = false
	
