extends Control

# Intro

export(String) var boss_level_path

func _ready():
	$AnimationPlayer.play("boss_intro")


func _goto_boss() -> void:
	LevelChanger.goto_scene(boss_level_path)
