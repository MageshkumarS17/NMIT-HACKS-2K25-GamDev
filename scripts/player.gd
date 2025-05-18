extends CharacterBody3D

var speed = 5.0
var mouse_sensitivity = 0.3
var gravity = 9.8
var jump_strength = 4.5
var has_key = false

@onready var camera = $Camera3D
@onready var flashlight = $Camera3D/SpotLight3D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		camera.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
	if event.is_action_pressed("ui_select"):
		flashlight.visible = !flashlight.visible

func _physics_process(delta):
	var input_dir = Vector3.ZERO
	input_dir.x = Input.get_axis("ui_left", "ui_right")
	input_dir.z = Input.get_axis("ui_up", "ui_down")
	input_dir = input_dir.normalized().rotated(Vector3.UP, rotation.y)

	if not is_on_floor():
		velocity.y -= gravity * delta

	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_strength

	velocity.x = input_dir.x * speed
	velocity.z = input_dir.z * speed
	move_and_slide()
