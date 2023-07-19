extends Node2D

@export var spawn_count: int = 200
@export var main_camera: Camera2D
const STAR_SCENE = preload("res://Loops/Star.tscn")

var stars: Array[Node] = []

# Called when the node enters the scene tree for the first time.
func _ready():	
	stars.clear()
	var cameraRect = _getCameraRect()
	_listenToResizeEvent()
	
	for star_index in spawn_count:
		var star = STAR_SCENE.instantiate()	
		var star_size = randf_range(0.5, 1.0)
		
		add_child(star)
		stars.push_back(star)
		
		star.position.x = randi_range(cameraRect.position.x, cameraRect.size.x + cameraRect.position.x)
		star.position.y = randi_range(cameraRect.position.y, cameraRect.size.y + cameraRect.position.y)
		star.scale.x = star_size
		star.scale.y = star_size
		

func _getCameraRect() -> Rect2:
	var cameraViewport = main_camera.get_viewport_rect().size
	cameraViewport /= main_camera.zoom
	return Rect2(-cameraViewport.x / 2, -cameraViewport.y / 2, cameraViewport.x, cameraViewport.y) 

func _listenToResizeEvent():
	if(get_tree().get_root().size_changed.get_connections().size() == 0):
		get_tree().get_root().size_changed.connect(_onResize)

func _onResize():
	for star in stars:
		if(!star == null):
			star.queue_free()
	_ready()
