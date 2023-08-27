extends CharacterBody3D

@export var move_speed: float = 1.0
@onready var _navigation_label: Label = get_node("/root/Main/Canvas/NavigationTypeLabel") as Label

var _is_direct_nav_mode: bool
var destination: Vector3

func _ready():
	_is_direct_nav_mode = true
	_navigation_label.text = "Current Navigation Type: direct"
	
func _update_label():
	if _is_direct_nav_mode:		
		_navigation_label.text = "Current Navigation Type: direct"
	else:
		_navigation_label.text = "Current Navigation Type: agent"
	
func _input(event):
	if event is InputEventKey and event.is_pressed():
		if(event as InputEventKey).keycode == KEY_Q:
			_is_direct_nav_mode = true
		if(event as InputEventKey).keycode == KEY_W:
			_is_direct_nav_mode = false
		_update_label()
	
	if event is InputEventMouseButton and event.is_pressed():
		if (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT:
			print("left mouse button pressed")
			var move_pos = _get_mouse_position_in_space(event)
			_move_to(move_pos)
		

func _get_mouse_position_in_space(event: InputEventMouseButton):
	var camera: Camera3D = get_node("/root/Main/Orbiter/Camera3D") as Camera3D
	var from = camera.project_ray_origin(event.position)
	var to = from + camera.project_ray_normal(event.position) * 100
	var cursor_pos = Plane(Vector3.UP, transform.origin.y).intersects_ray(from, to)
	print("cursor pos: ", str(cursor_pos))
	return cursor_pos

func _move_to(position: Vector3):
	destination = position
	
func _physics_process(delta):
	var position = global_position
	if destination != Vector3.ZERO:
		velocity = position.direction_to(destination).normalized() * move_speed
		if(position.distance_to(destination) <= 0.1):
			destination = Vector3.ZERO
			velocity = Vector3.ZERO
	
	move_and_slide()
