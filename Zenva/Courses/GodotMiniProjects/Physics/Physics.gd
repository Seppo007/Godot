extends RigidBody2D

const hit_force: float = 30.0

func _physics_process(delta):
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		var direction = global_position.direction_to(get_global_mouse_position())
		apply_impulse(direction * hit_force)
