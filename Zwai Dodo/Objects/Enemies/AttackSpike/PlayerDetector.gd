extends RayCast2D

export(float) var speed = 1000

onready var spike: KinematicBody2D = get_parent()
onready var despawnTimer = $DespawnTimer

var motion = Vector2(0,0)

func _ready():
	cast_to = Vector2(0, -1) * 600


func _physics_process(delta):
	if is_colliding():
		attack()
	
	spike.move_and_slide(motion * speed, Vector2.UP)


func attack():
	enabled = false
	motion = spike.global_position.direction_to(get_collision_point())
	if not despawnTimer.get_time_left() > 0:
		despawnTimer.start()
	


func _on_DespawnTimer_timeout():
	spike.queue_free()
