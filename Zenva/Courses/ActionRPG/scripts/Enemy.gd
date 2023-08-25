extends CharacterBody3D

var current_hp: int = 3
var maximum_hp: int = 3

var damage: int = 1
var attack_dist: float = 2.5
var attack_rate: float = 1.0

var move_speed: float = 2.5

var vel: Vector3 = Vector3()

@onready var timer = get_node("Timer")
@onready var player = get_node("/root/MainScene/Player")

func _ready():
	timer.wait_time = attack_rate
	timer.start()

func _on_timer_timeout():
	if position.distance_to(player.position) < attack_dist:
		player.take_damage(damage)
		
func _physics_process(delta):
	var distance_to_player = position.distance_to(player.position)
	
	if distance_to_player > attack_dist:
		var dir = (player.position - position).normalized()
		
		vel.x = dir.x * move_speed
		vel.y = 0
		vel.z = dir.z * move_speed
		
	velocity = vel
	
	move_and_slide()

func take_damage(damage_to_take):
	current_hp -= damage_to_take
	if current_hp <= 0:
		_die()

func _die():
	queue_free()
