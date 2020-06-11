extends Node

# Fireball Mover

export(float) var speed = 10

onready var body = get_parent()
onready var despawnTimer = $DespawnTimer
onready var sprite = body.get_node("Sprite")

var direction: Vector2

func _ready():
	sprite.frame = randi()%sprite.hframes


func _physics_process(delta):
	direction = Vector2(cos(body.rotation), sin(body.rotation))
	var collision = body.move_and_collide(direction * speed)


func _on_DespawnTimer_timeout():
	body.queue_free()
