extends Node2D


export(Vector2) var direction = Vector2.UP
export(float) var shoot_delay = 1

var arrow = preload("res://Objects/General/Arrow/Arrow.tscn")

onready var shootTimer = $ShootTimer
onready var shoot_pos = $ShootPoint.position

# Called when the node enters the scene tree for the first time.
func _ready():
	shootTimer.wait_time = shoot_delay
	shootTimer.start()


func _on_ShootTimer_timeout():
	shoot_arrow(direction)


func shoot_arrow(dir: Vector2):
	var new_arrow = arrow.instance()
	new_arrow.rotation = dir.angle()
	add_child(new_arrow)
#	new_arrow.set_position(shoot_pos) 
