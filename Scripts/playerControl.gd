extends CharacterBody3D

@export var SPEED_ACL = 0.25 #Speed multiplier for increasing speed
@export var SPEED_DCL = 1.5 #Speed multiplier for changing direction and 
@export var JUMP_VELOCITY = 9
@export var MOUSE_SENS = 0.001
@export var SLIDE_SPEED = 0.8
var SPEED
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")  * 2

func _unhandled_input(event): #Collects mouse data and applys to the character rotation
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * MOUSE_SENS)
		#CameraArm Allows for flexible camera
		$CameraArm.rotation.x = clamp($CameraArm.rotation.x - (-event.relative.y * MOUSE_SENS*0.5), deg_to_rad(-20), deg_to_rad(50)) #Locks mouse height to max and min

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	# Gravity Calc
	if not is_on_floor():
		velocity.y -= gravity * delta #Felt too floaty

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if not is_on_floor(): #Movement when in the air to allow some movement in air
		SPEED_ACL = 0.03
	else:
		SPEED_ACL = 0.3 
	var input_dir = Input.get_vector("ui_right", "ui_left", "ui_down", "ui_up") 
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() #Calculates world relative direction to travel
	print(direction)
	print(SPEED_ACL)
	if direction:
		if velocity.dot(direction) < 0.2: #Faster acceleration when switching direction to avoid large inertia
			SPEED = SPEED_DCL
		else:
			SPEED = SPEED_ACL
		velocity.x = clamp(velocity.x + direction.x * SPEED, -7, 7) #Speed calculations with clamps to limit max speed
		velocity.z = clamp(velocity.z + direction.z * SPEED, -7, 7)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED_DCL) #Deceleration
		velocity.z = move_toward(velocity.z, 0, SPEED_DCL)

	move_and_slide() #Additional godot calculations
