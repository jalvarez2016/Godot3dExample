extends CharacterBody3D

@export var gravity := 50.0
@export var speed := 8.0
@export var jump_force := 20.0

@onready var spring_arm: SpringArm3D = $SpringArm3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	var move_direction := Vector3.ZERO	
	move_direction.x = Input.get_axis("left", "right")
	move_direction.z = Input.get_axis("forward", "back")
	move_direction = move_direction.rotated(Vector3.UP, spring_arm.rotation.y).normalized()
	
	velocity.x = move_direction.x * speed
	velocity.z = move_direction.z * speed
	
	#Apply Gravity
	velocity.y -= delta * gravity
	
	move_and_slide()
	
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y = jump_force
