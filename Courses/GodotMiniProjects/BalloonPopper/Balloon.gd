extends Area3D

const CLICKS_TO_POP: int = 3
const SIZE_INCREASE: float = 0.2
const SCORE_TO_GIVE: int = 1

func _on_input_event(camera, event, position, normal, shape_idx):
	if(event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed):
		print("Increased size")
