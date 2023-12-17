extends CharacterBody3D

@export var gravity := 50.0
@export var speed := 8.0
@export var jump_force := 20.0
@export var health := 10

@onready var spring_arm: SpringArm3D = $SpringArm3D
@onready var mesh : MeshInstance3D = $MeshInstance3D

var angular_acceleration := 7
var isAlive := true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if !isAlive:
		return
	
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y = jump_force
	
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var move_direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	move_direction = move_direction.rotated(Vector3.UP, spring_arm.rotation.y).normalized()
	
	if move_direction:
		velocity.x = move_direction.x * speed
		velocity.z = move_direction.z * speed
		mesh.rotation.y = lerp_angle(mesh.rotation.y, atan2(move_direction.x, move_direction.z), delta * angular_acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()
	

func _on_area_3d_body_entered(body):
	if body.is_in_group('enemy'):
		health -= 1
		$ProgressBar.value = health * 10
		if (health <= 0):
			isAlive = false
			$GameOverScreen.visible = true
		#To prevent the enemy from sticking to the player and colliding we can push the player out of range
		velocity = body.linear_velocity * 15
		velocity.y = 0
		move_and_slide()
	
