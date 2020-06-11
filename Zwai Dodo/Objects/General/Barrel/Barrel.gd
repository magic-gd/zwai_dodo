extends StaticBody2D


func take_damage(source, amount):
	explode()


func explode():
	$AnimationPlayer.play("explode")


func deal_damage():
	for body in $HurtArea.get_overlapping_bodies():
		if body.is_in_group("hurtbox"):
			body.take_damage(global_position, 10)


func destroy():
	queue_free()
