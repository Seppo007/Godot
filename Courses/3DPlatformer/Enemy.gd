extends Area3D

@export var move_speed: float = 2.0
@export var move_direction: Vector3

var start_position: Vector3
var target_position: Vector3

func _ready():
	start_position = global_position
	target_position = start_position + move_direction
	
func _process(delta):
	global_position = global_position.move_toward(target_position, move_speed * delta)

	if(global_position == target_position):
		if(global_position == start_position):
			target_position = start_position + move_direction
		else:
			target_position = start_position
