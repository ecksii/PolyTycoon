extends Control

var mouse_in: bool = false
var is_dragging: bool = false

func _physics_process(delta) -> void:
	swipe_logic(delta)
	_set_rotation(delta)

func swipe_logic(delta: float):
	if (mouse_in or is_dragging):
		if (Input.is_action_pressed("L_click")):
			global_position = lerp(global_position, get_global_mouse_position() - (size/2.0), 22.0 * delta)
			is_dragging = true
		else: 
			is_dragging = false
			
var last_pos: Vector2
var max_card_rotation: float = 12.5
func _set_rotation(delta: float):
	var desired_rotation: float = clamp((global_position - last_pos).x *0.85, -max_card_rotation, max_card_rotation)
	rotation_degrees = lerp(rotation_degrees, desired_rotation, 12.0 * delta)
	last_pos = global_position

func _on_mouse_entered():
	mouse_in = true

func _on_mouse_exited():
	mouse_in = false
