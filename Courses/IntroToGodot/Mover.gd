extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var vec = Vector2(500, 200)
	global_position = vec

var timer: float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2(1,1) * 30 * delta
	global_position += direction
