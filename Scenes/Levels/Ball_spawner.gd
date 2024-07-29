extends Node3D

var object_scene = preload("res://objects/Ball.tscn")
@export var object: NodePath

var timer: Timer
var current_object: RigidBody3D

func _ready():
	timer = Timer.new()
	timer.one_shot = false
	timer.start()
	timer.paused = false
	timer.autostart = true
	timer.wait_time = 6.
	add_child(timer)
	timer.connect("timeout", _on_Timer_timeout)
	_spawn_new_object()

func _process(delta):
	print(timer.is_stopped())

func _spawn_new_object():
	if current_object:
		current_object.queue_free()
	var new_object = object_scene.instantiate()
	add_child(new_object)
	new_object.global_transform = global_transform
	current_object = new_object
	object = new_object.get_path()

func _on_Timer_timeout():
	if object:
		var obj: RigidBody3D = get_node(object)
		obj.global_transform.origin = global_transform.origin
		_spawn_new_object()
