extends Area2D

var bob_height: float = 5.0
var bob_speed: float = 5.0

@onready var start_y: float = global_position.y
var time: float = 0.0

func _process(delta):
	time += delta
	
	var sin_pos = (sin(time * bob_speed) + 1) / 2
	global_position.y = start_y + (sin_pos * bob_height)

func _on_body_entered(body):
	if(body.is_in_group("Player")):
		body.add_score(1)
		queue_free()
