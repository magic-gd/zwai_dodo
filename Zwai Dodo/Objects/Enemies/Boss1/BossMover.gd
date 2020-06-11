extends Node
#
# Moves Boss1
#

export(int) var speed = 200
export(int) var gravity = 20
export(float) var jump_time = 2.0
export(float) var jump_height = 2000

onready var body : KinematicBody2D = get_parent()
onready var jump_timer : Timer = $JumpTimer
# lul
onready var player: PlayerController = body.get_parent().get_parent().find_node("Dodo")

var motion = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	jump_timer.set_wait_time(jump_time)
	jump_timer.start()

func _physics_process(delta):
	motion.y += gravity
	motion.x *= 0.99
	motion = body.move_and_slide(motion, Vector2.UP, false, 4, PI/4, false)


func jump_attack():
	var jump_target = player.global_position + Vector2(0, -jump_height)
	motion += body.global_position.direction_to(jump_target) * jump_height


func _on_JumpTimer_timeout():
	jump_attack()
