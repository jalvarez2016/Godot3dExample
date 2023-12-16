extends RigidBody3D

var speed := 10.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += global_transform.basis.z * speed * delta;
	pass
