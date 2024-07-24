extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_copy"):
		invert_gravity()

	if event.is_action_pressed("ui_cut"):
		set_freeze_enabled(!freeze)
		print(freeze)

func invert_gravity():
	set_gravity_scale(-gravity_scale)
	wake_up()

func wake_up():
	sleeping = false
