extends Node2D

@export var spawn_count: int = 200
@export var main_camera: Camera2D
const STAR_SCENE = preload("res://Loops/Star.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():	
	var cameraRect = _getCameraRect()
	
	for star_index in spawn_count:
		var star = STAR_SCENE.instantiate()
		add_child(star)
	
		star.position.x = randi_range(cameraRect.position.x, cameraRect.size.x + cameraRect.position.x)
		star.position.y = randi_range(cameraRect.position.y, cameraRect.size.y + cameraRect.position.y)

func _getCameraRect() -> Rect2:
	var cameraViewport = main_camera.get_viewport_rect().size
	cameraViewport /= main_camera.zoom
	return Rect2(-cameraViewport.x / 2, -cameraViewport.y / 2, cameraViewport.x, cameraViewport.y) 
