extends Node3D

@onready var orbiter: Node3D = get_node("Orbiter")
var _last_mouse_pos: Vector2
var _mouse_move: float = 0.0

func _process(delta):
	var current_mouse_pos: Vector2 = get_viewport().get_mouse_position()
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		var mouse_move = current_mouse_pos - _last_mouse_pos
		orbiter.rotate_y(mouse_move.x / 1000)
		orbiter.rotate_y(_mouse_move)
		
	_last_mouse_pos = current_mouse_pos
