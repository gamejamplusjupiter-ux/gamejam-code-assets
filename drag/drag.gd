class_name DragObject
extends Node2D

var is_dragging = false
var of = Vector2(0, 0)

func _process(delta: float) -> void:
	if is_dragging:	
		position = get_global_mouse_position() - of

func _on_button_button_down() -> void:
	print("a")
	is_dragging = true
	of = get_global_mouse_position() - global_position


func _on_button_button_up() -> void:
	is_dragging = false
