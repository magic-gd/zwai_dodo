extends Node

# PLayerData

signal change()
signal gun_unlock()

const MAX_HEALTH = 3
const MAX_AMMO = 500

var has_gun: bool = false setget set_has_gun
var health: int = 3 setget set_health
var lives: int = 10 setget set_lives
var ammo: float = 0 setget set_ammo



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_health(new_health: int) -> void:
	health = new_health
	emit_signal("change")


func set_lives(new_lives: int) -> void:
	lives = new_lives
	emit_signal("change")


func set_ammo(new_ammo: float) -> void:
	ammo = new_ammo
	emit_signal("change")


func set_has_gun(has: bool) -> void:
	has_gun = has
	if has_gun:
		set_ammo(MAX_AMMO)
		emit_signal("gun_unlock")
		


func heal(amount) -> void:
	if health < MAX_HEALTH:
		set_health(min(health + amount, MAX_HEALTH))


func gain_ammo(amount) -> void:
	set_ammo(min(ammo + amount, MAX_AMMO))


func reset():
	has_gun = false
	health = MAX_HEALTH
	lives = 10
	ammo = 0
	
