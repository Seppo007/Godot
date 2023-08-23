extends CharacterBody3D

var current_hp: int = 10
var maximum_hp: int = 10
var damage: int = 1

var gold: int = 0

var attack_rate: float = 0.3
var last_attack_time: int = 0

var move_speed: float = 5.0
var jump_force: float = 10.0
var gravity: float = 15.0

var vel: Vector3 = Vector3()

@onready var camera = get_node("CameraOrbit")
@onready var attack_ray_cast = get_node("AttackRayCast")

func _physics_process(delta):
	vel.x = 0
	vel.z = 0
	
	var input = Vector3()
	
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y = jump_force
	if Input.is_action_pressed("move_forward"):
		input.z += 1
	if Input.is_action_pressed("move_backward"):
		input.z -= 1
	if Input.is_action_pressed("move_left"):
		input.x += 1
	if Input.is_action_pressed("move_right"):
		input.x -= 1
		
	input = input.normalized()
	
	var direction: Vector3 = (transform.basis.z * input.z + transform.basis.x * input.x)
	
	vel.y -= gravity * delta
	vel.x = direction.x * move_speed
	vel.z = direction.z * move_speed	
		
	velocity = vel
	
	move_and_slide()
	
func give_gold(amount):
	gold += amount
	
func take_damage(damage_to_take):
	current_hp -= damage_to_take
	if current_hp <= 0:
		_die()

func _die():
	get_tree().reload_current_scene()
