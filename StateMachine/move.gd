extends State

@export var jump_state: State

@export var idle_state: State


func enter() -> void:
	super()
	
	
func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		return jump_state
	return null
	
func process_physics(delta: float) -> State:
	var movement = Input.get_axis("move_left", "move_right") * move_speed
	
	
	if movement == 0.0:
		print(movement)
		return idle_state
	parent.animation.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	return null
