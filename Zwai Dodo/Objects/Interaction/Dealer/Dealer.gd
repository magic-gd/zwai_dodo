extends "res://Objects/Interaction/InteractionArea.gd"

# Dealer

export(String, "Mana", "Health") var dealer_type = "Mana"

onready var anim_sprite = $AnimatedSprite

# Override
func _ready():
	anim_sprite.set_animation(dealer_type)
	._ready()


#Override
func activate() -> void:
#	print("dealer activate")
	match dealer_type:
		"Mana":
			pass
		"Health":
			PlayerData.health = PlayerData.MAX_HEALTH + 2

