extends RigidBody3D

@export var move_speed: float = 0.1
var finished: bool = false

func _physics_process(delta):
	if(!finished):
		if(Input.is_key_pressed(KEY_LEFT)):
			linear_velocity.x -= move_speed
		if(Input.is_key_pressed(KEY_RIGHT)):
			linear_velocity.x += move_speed

func _on_body_entered(body):
	if(body.is_in_group("Tree")):
		get_tree().reload_current_scene()

func _on_goal_body_entered(body: RigidBody3D):
	if(body.is_in_group("Player")):
		finished = true
		body.linear_velocity *= 0.15
		var material = PhysicsMaterial.new()
		material.friction = 1.0
		body.physics_material_override = material


func _on_out_of_game_area_body_entered(body):
	if(body.is_in_group("Player")):
		get_tree().reload_current_scene()
