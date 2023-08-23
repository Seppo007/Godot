extends Area3D

@export var gold_to_give: int = 1
var rotate_speed: float = 5.0

func _process(delta):
	rotate_y(rotate_speed * delta)

func _on_body_entered(body):
	if body.name == "Player":
		body.give_gold(gold_to_give)
		queue_free()
