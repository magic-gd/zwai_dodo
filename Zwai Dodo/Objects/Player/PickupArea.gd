extends Area2D

# PickupArea

var _selection: Array = []

func _input(event):
	if event.is_action_pressed("interact"):
		activate()


func _on_PickupArea_area_entered(area: Area2D):
	if area.is_in_group("interaction"):
#		print("area entered")
		_selection.append(area)


func _on_PickupArea_area_exited(area):
	if area.is_in_group("interaction"):
#		print("area exited")
		_selection.erase(area)

func activate() -> void:
	if _selection.size() == 0:
		return
	
	_selection[0].activate()


