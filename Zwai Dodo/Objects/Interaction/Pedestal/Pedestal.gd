extends "res://Objects/Interaction/InteractionArea.gd"

# Pedestal

export(String, "Mana", "Health", "Gun", "Empty") var pedestal_type = "Gun"
export(float) var regrow_time = 0

onready var anim_sprite = $AnimatedSprite
onready var regrowTimer = $RegrowTimer

# Override
func _ready():
	anim_sprite.set_animation(pedestal_type)
	._ready()


#Override
func activate() -> void:
#	print("pedestal activate")
	match anim_sprite.get_animation():
		"Empty":
			return
		"Mana":
			PlayerData.gain_ammo(PlayerData.MAX_AMMO / 3)
		"Health":
			PlayerData.heal(1)
		"Gun":
			PlayerData.has_gun = true
	anim_sprite.set_animation("Empty")
	if regrow_time > 0:
		regrowTimer.start(regrow_time)
	


func _on_RegrowTimer_timeout():
	anim_sprite.set_animation(pedestal_type)
