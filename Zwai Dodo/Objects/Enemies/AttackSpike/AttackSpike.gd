extends "res://Objects/Enemies/Enemy.gd"

# AttackSpike

#Override
func _on_CollisionArea_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage($ThrowPoint.global_position, throw_strength)
		queue_free()
