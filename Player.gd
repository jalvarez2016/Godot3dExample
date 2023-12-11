extends CharacterBody3D

@export var gravity := 50.0
@export var speed := 8.0
@export var jump_force := 20.0

@onready var spring_arm: SpringArm3D = $SpringArm3D
@onready var mesh : Node3D = $GDbotSkin

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y = jump_force
	
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var move_direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	move_direction = move_direction.rotated(Vector3.UP, spring_arm.rotation.y).normalized()
	mesh.look_at($GDbotSkin/Marker3D.global_position + Vector3(velocity.x, 0, velocity.z), Vector3.UP)
	
	if move_direction:
		mesh.walk()
		velocity.x = move_direction.x * speed
		velocity.z = move_direction.z * speed
	else:
		mesh.idle()
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()
	
