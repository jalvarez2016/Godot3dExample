extends RigidBody3D

const SPEED = 100.0
var player_detected = false
var player = null

@export var health := 1

func _physics_process(_delta):
	if player_detected:
		var move_direction = (player.global_position - global_position).normalized();
		apply_central_force(move_direction * SPEED)

func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		player = body
		player_detected = true


func _on_area_3d_body_exited(body):
	if body.is_in_group("player"):
		player = null
		player_detected = false


func _on_bullet_hit(body):
	if body.is_in_group("bullet"):
		health -= 1
		if health <= 0:
			queue_free()
