extends KinematicBody

export var speed: float = 10.0
export var acceleration: float = 12.0
export var deceleration: float = 8.0

export var mouse_sensitivity: float = 0.15
export var gravity: float = 20.0
export var jump: float = 10.0

var min_pitch: float = -80.0
var max_pitch: float = 80.0

onready var head = $Head

var velocity = Vector3.ZERO

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		
		head.rotation_degrees.x = clamp(head.rotation_degrees.x, min_pitch, max_pitch)
		
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	var motion = Vector3.ZERO
	motion.z = Input.get_axis("ui_up", "ui_down")
	motion.x = Input.get_axis("ui_left", "ui_right")
	
	var direction = (transform.basis.z * motion.z + transform.basis.x * motion.x)
	
	if direction.length() > 0:
		direction = direction.normalized()
	
	var velocity_x = direction.x * speed
	var velocity_z = direction.z * speed
	
	if direction != Vector3.ZERO:
		velocity.x = lerp(velocity.x, velocity_x, acceleration * delta)
		velocity.z = lerp(velocity.z, velocity_z, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0, deceleration * delta)
		velocity.z = lerp(velocity.z, 0, deceleration * delta)
	
	var snap_vector = Vector3.DOWN * 8.0 if is_on_floor() else Vector3.ZERO
	
	if is_on_floor():
		if Input.is_action_pressed("ui_accept"):
			print("jump")
			velocity.y += jump
			snap_vector = Vector3.ZERO
		else:
			velocity.y = -0.1
	else:
		velocity.y -= gravity * delta
	
#	print("Z - ", motion.z, " X - ", motion.x, " SPEED - ", speed)
	
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector3.UP, true)
