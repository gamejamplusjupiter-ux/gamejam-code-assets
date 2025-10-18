class_name Player
extends CharacterBody2D

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $StateMachine
@onready var state: Label = $State
@export var speed := 200.0
@onready var muzzle := $ShootPoint

@onready var vida_atual : int = 30

# -- Tiro -- 
#@onready var bullet_scene := preload("res://Projectiles/Projectiles.tscn")
@onready var shoot_point: Node2D = $ShootPoint
@onready var shoot_point_position_x = shoot_point.position.x

@onready var projectile_scene: PackedScene


var can_move := true
#var music_area_array : Array[MusicArea] = [] # array to stack all entered music areas

func _ready() -> void:
	state_machine.init(self)
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func dano_jogador() -> void:
	if morto:
		return
		
	# Aplica dano
	vida_atual -= 10
	vida_alterada.emit(vida_atual)
	
	comecar_piscar()
	
	if vida_atual <= 0:
		morrer()
		

func knockdown():
	can_move = false
	await get_tree().create_timer(1.5).timeout
	can_move = true

	
func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	state.text = state_machine.current_state.name
