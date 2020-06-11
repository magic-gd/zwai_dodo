extends Node
#
# Moves Boss2
#

export(int) var speed = 200
export(int) var gravity = 20
export(float) var move_time = 2.0
export(float) var shoot_time = 1
export(float) var fly_speed = 2000

onready var body : KinematicBody2D = get_parent()
onready var mouth = body.get_node("Mouth")
onready var shootTimer : Timer = $ShootTimer
onready var moveTimer: Timer = $MoveTimer
# lul
onready var player: PlayerController = body.get_parent().get_parent().find_node("Dodo")
#omegalul
onready var movePoints = body.get_parent().find_node("MovePoints")
onready var dragonAnimationPlayer = body.get_node("DragonAnimationPlayer")

var motion = Vector2(0,0)
var flying: bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	shootTimer.start(shoot_time)
	moveTimer.start(move_time)

func _physics_process(delta):
	motion.y += gravity
	motion.x *= 0.99
	motion = body.move_and_slide(motion, Vector2.UP, false, 4, PI/4, false)
	_update_look_direction()


func fly_attack():
#	print("fly_attack")
	moveTimer.start(rand_range(1, move_time))
	var targets = []
	for child in movePoints.get_children():
		if child.name.begins_with("FlyPoint"):
			targets.append(child)
	
	var target_pos = targets[randi()%targets.size()].global_position
	gravity = -50
	dragonAnimationPlayer.play("fly")
	flying = true
	motion.x += body.global_position.direction_to(target_pos).x * fly_speed


func sit_attack():
#	print("sit_attack")
	moveTimer.start(move_time * 2)
	var targets = []
	for child in movePoints.get_children():
		if child.name.begins_with("SitPoint"):
			targets.append(child)
	
	gravity = 100
	dragonAnimationPlayer.play("sit")
	flying = false
	motion.x = 0


func shoot_fireball():
	var direction = mouth.global_position.direction_to(player.global_position)
	var fireball = preload("res://Objects/Enemies/Boss2/Fireball.tscn").instance()
	fireball.set_rotation(direction.angle())
	body.get_parent().add_child(fireball)
	fireball.set_global_position(mouth.global_position)


func choose_movement():
	if not flying:
		fly_attack()
	else:
		sit_attack() if randi()%5 == 0 else fly_attack()


func _update_look_direction():
	var look_right = player.global_position.x > body.global_position.x
	
	var direction = -1 if look_right else 1
	# This is a bug in godot probably
	body.scale.x = body.scale.y * direction


func _on_ShootTimer_timeout():
	shoot_fireball()
	shootTimer.start(rand_range(1, shoot_time))
	


func _on_MoveTimer_timeout():
	choose_movement()
