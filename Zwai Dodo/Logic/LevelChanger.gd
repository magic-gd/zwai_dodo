extends Node

var current_scene_path: String

func goto_scene(path : String) -> void:
	if path:
		current_scene_path = path
		get_tree().change_scene(path)


func goto_scene_at(path: String, position: Vector2) -> void:
	goto_scene(path)
	yield(get_tree(), "idle_frame")
	for player in get_tree().get_nodes_in_group("player"):
		player.set_global_position(position)


func restart_scene():
	get_tree().reload_current_scene()
	PlayerData.heal(PlayerData.MAX_HEALTH)


func game_over():
	PlayerData.reset()
	goto_scene("res://GUI/GameOverScreen/GameOverScreen.tscn")
