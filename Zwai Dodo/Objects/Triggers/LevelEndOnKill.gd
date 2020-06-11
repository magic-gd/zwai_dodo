extends Node

export(String) var next_level_path
export(String) var enemy_name

onready var checkTimer = $CheckTimer

func next_level():
	LevelChanger.goto_scene(next_level_path)


func _on_CheckTimer_timeout():
	var enemy = get_parent().find_node(enemy_name, true)
	if not enemy:
		next_level()
