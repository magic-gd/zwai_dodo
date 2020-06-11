extends "res://Objects/Interaction/InteractionArea.gd"

# Dealer

export(String, "Mana", "Health") var vending_type = "Mana"

onready var anim_sprite = $AnimatedSprite

# Override
func _ready():
	anim_sprite.set_animation(vending_type)
	._ready()


#Override
func activate() -> void:
#	print("vending activate")
	match vending_type:
		"Mana":
			PlayerData.gain_ammo(PlayerData.MAX_AMMO)
		"Health":
			PlayerData.heal(1)
