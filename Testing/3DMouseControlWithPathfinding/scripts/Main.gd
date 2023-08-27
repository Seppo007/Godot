extends Node3D

@onready var orbiter: Node3D = get_node("Orbiter") as Node3D
@onready var player_script = get_node("Player")

@onready var _navigation_label: Label = get_node("Canvas/NavigationTypeLabel") as Label
@onready var _direct_button: Button = get_node("Canvas/Control/DirectButton") as Button
@onready var _agent_button: Button = get_node("Canvas/Control/AgentButton") as Button

var _last_mouse_pos: Vector2
var _mouse_move: float = 0.0

var _is_direct_nav_mode: bool

func _set_direct_nav_mode(direct: bool):
	_is_direct_nav_mode = direct
	_update_label()
	player_script.set_direct_nav_mode(direct)

func _ready():
	_set_direct_nav_mode(true)
	
	_direct_button.pressed.connect(self._on_direct_btn_clicked)
	_agent_button.pressed.connect(self._on_agent_btn_clicked)

func _on_direct_btn_clicked():
	_set_direct_nav_mode(true)
	
func _on_agent_btn_clicked():
	_set_direct_nav_mode(false)	

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
		player_script.set_direct_nav_mode(_is_direct_nav_mode)
		_update_label()

func _process(delta):
	var current_mouse_pos: Vector2 = get_viewport().get_mouse_position()
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		var mouse_move = current_mouse_pos - _last_mouse_pos
		orbiter.rotate_y(mouse_move.x / 1000)
		orbiter.rotate_y(_mouse_move)
		
	_last_mouse_pos = current_mouse_pos
