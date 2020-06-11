extends "res://Objects/Enemies/Enemy.gd"

# CloudEnemy.gd

func _on_SpawnTimer_timeout():
	_strike_lightning()


func _strike_lightning() -> void:
	var BoltHurtShape = $CollisionArea/BoltHurtShape
	var BoltSprite = $BoltSpawner/BoltSprite
	
	var body_size = int($BodyShape.get_shape().get_height())
	var random_spread = Vector2(randi()%body_size - body_size/2, randi()%(body_size/2)) 
	var spawn_position = $BoltSpawner.get_global_position() + random_spread
	
	BoltHurtShape.set_global_position(spawn_position)
	BoltSprite.set_global_position(spawn_position)
	
	$BoltSpawner/AnimationPlayer.play("strike")
