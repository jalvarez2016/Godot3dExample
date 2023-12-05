extends RayCast3D
var object_class = preload("res://ball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if  is_colliding():
		var root = get_tree().get_root().get_node("World")
		var collision_point = get_collision_point()
		if Input.is_action_just_pressed("shoot"):
			var object_instance = object_class.instantiate()
			object_instance.position = $"../../..".global_position
			object_instance.position.y += 2
			root.add_child(object_instance)
			object_instance.apply_impulse(collision_point)
