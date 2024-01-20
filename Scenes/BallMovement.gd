extends RigidBody3D

@export var SPEED_ACL = 0.25 #Speed multiplier for increasing speed
@export var SPEED_STRF = 0.5
@export var SPEED_DCL = 1.5 #Speed multiplier for changing direction and 
@export var JUMP_VELOCITY = 5
@export var MOUSE_SENS = 0.001
@export var SLIDE_SPEED = 0.8
var isActive = false
var SPEED = 50
var curRotation = 0
var MAX_SPEED = 5
var prevvelocity
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")  * 2


func _ready():
	$CameraArm.top_level = true
	$FloorCast.top_level = true

func _process(delta):
	$CameraArm.global_transform.origin = Vector3(global_transform.origin.x,global_transform.origin.y + 2, global_transform.origin.z)
	$FloorCast.global_transform.origin = global_transform.origin
	
	#if linear_velocity.length() > MAX_SPEED:
	#	linear_velocity = prevvelocity
	#prevvelocity = linear_velocity
	
func _physics_process(delta):
	pass





