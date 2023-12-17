extends RigidBody3D

@export var initialForce = 100.00

func _ready():
	apply_central_impulse(global_transform.basis.z * initialForce)
