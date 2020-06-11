extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AmmoDisplay.max_value = PlayerData.MAX_AMMO
	PlayerData.connect("change", self, "_on_PlayerData_change")
	
	_display_player_data()



func _display_player_data() -> void:
	display_health(PlayerData.health)
	display_ammo(PlayerData.ammo)
	display_lives(PlayerData.lives)


func display_health(health: int) -> void:
	for child in $HealthDisplay.get_children():
		child.queue_free()
		
	var healthHeart = preload("res://GUI/Player/HealthHeart.tscn")
	for i in range(health):
		$HealthDisplay.add_child(healthHeart.instance())


func display_ammo(ammo: float) -> void:
	$AmmoDisplay.value = ammo


func display_lives(lives: int) -> void:
	$LivesDisplay/HBoxContainer/Label.text = str(lives)


func _on_PlayerData_change():
	_display_player_data()
