extends Node2D

# LaserGun


export(int) var max_laser_length = 10000

onready var shootPoint = $Sprite/ShootPoint
onready var rayCast = $Sprite/ShootPoint/RayCast2D
onready var sprite = $Sprite
onready var laserEnd = $Sprite/ShootPoint/LaserEnd
onready var laserBeam = $Sprite/ShootPoint/LaserBeam
onready var hurtArea = $Sprite/ShootPoint/LaserEnd/HurtArea
onready var player = get_parent()
onready var controllerInput = $ControllerInput

# Dictionary of all previously hit bodies, and their heat
# Because this is a very reasonable thing to do. Totally.
var heat_list: Dictionary = {}

func _ready():
	rayCast.cast_to = Vector2(max_laser_length, 0)


func _physics_process(delta):
	_aim()
	_shoot()
	_cool()

func _aim() -> void:
	var aim_position: Vector2
	var max_target: Vector2
	
	if controllerInput.controller_active:
		aim_position = controllerInput.controllerAimPoint.position
		sprite.rotation = aim_position.angle()
		# i did this in 5 mins no hate
		max_target = shootPoint.global_position.direction_to(controllerInput.controllerAimPoint.global_position) * max_laser_length
	else:
		aim_position = get_local_mouse_position()
		sprite.rotation = aim_position.angle()
		max_target = shootPoint.get_local_mouse_position().normalized() * max_laser_length
	
	if rayCast.is_colliding():
		laserEnd.global_position = rayCast.get_collision_point()
	else:
		laserEnd.position = rayCast.cast_to
	laserBeam.rotation = rayCast.cast_to.angle()
	
	# For some reason theres a difference in length units for vectors and sprite rects.
	# And I'm not dealing with it. This kinda works.
	laserBeam.region_rect.end.x = laserEnd.position.length() * 0.33


func _shoot() -> void:
	var too_close: bool = false
	if not controllerInput.controller_active:
		too_close = get_global_mouse_position().distance_to(global_position) < shootPoint.global_position.distance_to(global_position) + 2
		
	var can_shoot: bool = visible and PlayerData.ammo > 0 and Input.is_action_pressed("shoot") and not too_close
	laserBeam.visible = can_shoot
	laserEnd.visible = can_shoot
	if not can_shoot:
		return
	
	player.push_to(laserEnd.global_position.direction_to(shootPoint.global_position) * Vector2(5,8))
	
	var hit_bodies = hurtArea.get_overlapping_bodies()
	for body in hit_bodies:
		# You can really tell I don't care anymore
		# Increase heat_list entry of all hit bodies by 1
		if body.is_in_group("hurtbox"):
			if heat_list.has(body):
				heat_list[body] = heat_list[body] + 1
			else:
				heat_list[body] = 1.0
			
			if heat_list[body] >= 50:
				body.take_damage(hurtArea.global_position, 1)
				heat_list[body] = heat_list[body] / 2
	
	PlayerData.ammo -= 0.5


# Cool all previously hit bodies
func _cool() -> void:
	for entry in heat_list:
		var heat = heat_list[entry]
		if heat > 0.01:
			heat_list[entry] = max(0, heat - 0.1)
#			print(heat_list[entry])
