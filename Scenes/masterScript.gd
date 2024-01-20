extends Node3D
var Level: int = 1 # 0 Humanoid (Start), 1 Ball
var curForm: int = 0 # 0 Humanoid, 1 Ball

# Called when the node enters the scene tree for the first time.
func _ready():
	$Humanoid.isActive = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("form_change"):
		match curForm:
			0:
				if Level > 0:
					$Humanoid.isActive = false
					$Ball.isActive = true
					$Ball/CameraArm/Camera3D.make_current()
					$Ball.position = $Humanoid.position + Vector3(0,1,0)
					$Ball.linear_velocity = $Humanoid.velocity
					$Humanoid.visible = false
					$Ball.visible = true
					curForm = 1
			1:
				$Humanoid.isActive = true
				$Ball.isActive = false
				$Humanoid/CameraArm/Camera3D.make_current()
				$Humanoid.position = $Ball.position
				$Humanoid.velocity = $Ball.linear_velocity
				$Ball.visible = false
				$Humanoid.visible = true
				curForm = 0
		
