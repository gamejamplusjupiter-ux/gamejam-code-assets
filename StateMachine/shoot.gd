extends Node

@export var shoot: State
@export var idle_state: State
@onready var shoot_point: Node2D = $ShootPoint

var esta_atirando := false
var pode_atirar: bool = true 
var municao = 1
var pentes = 3
var municao_pente = 1
var time_holding = 0.0
var tiros_jogoador = 0

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("shoot"):
		shoot.play()
	return null
	
func _on_hurtbox_body_entered(body: Node2D) -> void:
	var alvo = body.get_parent()
	if alvo.is_in_group("projetil_inimigo") or alvo.is_in_group("inimigos"):
		print("dano aplicado ao player via body:", alvo.name)
		if alvo.is_in_group("projetil_inimigo"):
			alvo.queue_free()


func shoot_function():	
	if municao <= 0:
		return

	esta_atirando = true
	tiros_jogador += 1
	municao -= 1

	# Instancia o projétil
	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)
	projectile.global_position = shoot_point.global_position

	# Define direção do projétil
	var dir = Vector2.RIGHT if not sprite_animado.flip_h else Vector2.LEFT
	projectile.initialize(dir)
	
	await get_tree().create_timer(0.2).timeout
	esta_atirando = false
	
	
