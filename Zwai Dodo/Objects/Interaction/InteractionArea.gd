extends Area2D

func _ready():
	add_to_group("interaction")


func _on_Area2D_area_entered(area):
	if area.is_in_group("player"):
		modulate = Color("#6668ff")


func _on_Area2D_area_exited(area):
	if area.is_in_group("player"):
		modulate = Color("#ffffff")


func activate() -> void:
	pass
