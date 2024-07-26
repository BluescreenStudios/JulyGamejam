extends CharacterBody3D

@onready var camera = $Camera3D
@onready var camera_should_move = true
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var being_pulled = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravity_inverted = gravity < 0
var grounded
var inverse = 1

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _unhandled_input(event: InputEvent):
	if Input.is_action_just_pressed("ui_menu"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		camera_should_move = false
		
	if event is InputEventMouseButton:
		camera_should_move = true
		
	if event is InputEventMouseMotion and camera_should_move:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

		rotate_y(-event.relative.x * .005 * inverse)
		camera.rotate_x(-event.relative.y * .005)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2.4, PI/2.4)

func _physics_process(delta):
	handle_grav()
	
	if being_pulled:
		return
		
	if not grounded:
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("ui_accept") and grounded:
		if not gravity_inverted:
			velocity.y = JUMP_VELOCITY
		else:
			velocity.y = -JUMP_VELOCITY

	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
var Just_turned_grav = false

func handle_grav():
	inverse = 1
	if gravity_inverted:
		inverse = -1
		
	gravity_inverted = gravity < 0
	grounded = (is_on_floor() and not gravity_inverted) or (is_on_ceiling() and gravity_inverted)
	
	if gravity_inverted and Just_turned_grav:
		Just_turned_grav = false
		position.y += 2.5
		global_rotate(Vector3(1, 0, 0), PI)
		rotate_y(90)
	elif not gravity_inverted and Just_turned_grav:
		global_rotate(Vector3(1, 0, 0), PI)
		rotate_y(90)
		position.y -= 2.5
		Just_turned_grav = false
		
