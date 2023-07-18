extends CharacterBody2D

const MOVE_SPEED: float = 200.0

func _physics_process(delta):
	velocity = Vector2()
	
	if(Input.is_key_pressed(KEY_LEFT)):
		velocity.x -= 1
	if (Input.is_key_pressed(KEY_RIGHT)):
		velocity.x += 1
	if(Input.is_key_pressed(KEY_UP)):
		velocity.y -= 1
	if (Input.is_key_pressed(KEY_DOWN)):
		velocity.y += 1
		
	velocity *= MOVE_SPEED
				
	move_and_slide()
