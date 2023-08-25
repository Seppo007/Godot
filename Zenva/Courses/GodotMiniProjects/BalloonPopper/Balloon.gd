extends Area3D

@export var clicks_to_pop: int = 5
@export var SIZE_INCREASE: float = 0.2
@export var SCORE_TO_GIVE: int = 1

func _on_input_event(camera, event, position, normal, shape_idx):
	if(event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed):
		scale += Vector3.ONE * SIZE_INCREASE
		clicks_to_pop -= 1
		
		if(clicks_to_pop == 0):
			get_node("/root/Main").increase_score(SCORE_TO_GIVE)
			queue_free()
