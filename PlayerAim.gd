extends Camera3D
var object_class = preload("res://ball.tscn")

@onready var shoot_position = $"../../MeshInstance3D/Marker3D"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var root = get_tree().get_root().get_node("World")
	if Input.is_action_just_pressed("shoot"):
		print("shoot")
		var object_instance = object_class.instantiate()
		object_instance.position = shoot_position.global_position
		object_instance.rotation.y = $"../../MeshInstance3D".rotation.y
		root.add_child(object_instance)
