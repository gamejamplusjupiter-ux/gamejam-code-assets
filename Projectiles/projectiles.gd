extends CharacterBody2D

@export var speed := 600.00
@onready var animation_projectile: AnimatedSprite2D = $AnimatedSprite2D
var direction := Vector2.ZERO

func _ready():
	add_to_group("projetil")
	animation_projectile.play()

func initialize(dir: Vector2) -> void:
	direction =dir.normalized()
	look_at(global_position + direction)

func _physics_process(delta):
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		queue_free()
	else:
		position += direction * speed * delta
	
func _on_life_timer_timeout():
	queue_free()


func _on_enemy_detector_body_entered(body: Node2D) -> void:
	if body.name == "Enemy":
		body.queue_free() #dai o inimigo morre
		speed = 0 #para o projetil pra ficar no mapa
	elif body.name == "Player":
		if body.has_method("knockdown"):
			body.knockdown()
		speed = 0
		
