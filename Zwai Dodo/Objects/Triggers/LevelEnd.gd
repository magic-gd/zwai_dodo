extends Area2D

export(String) var next_level_path
export(bool) var keep_position = false
export(Vector2) var custom_position

func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		if keep_position:
			LevelChanger.goto_scene_at(next_level_path, body.position)
		elif custom_position:
			LevelChanger.goto_scene_at(next_level_path, custom_position)
		else:
			LevelChanger.goto_scene(next_level_path)
