extends Control




func _on_Button_pressed():
	PlayerData.reset()
	LevelChanger.goto_scene("res://World/Levels/Level1.tscn")


func _on_Button2_pressed():
	LevelChanger.goto_scene("res://GUI/ControlsScreen/ControlsScreen.tscn")
