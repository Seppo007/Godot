extends Unit

@onready var selectionVisual: Sprite2D = get_node("SelectionVisual")

func toggle_selection_visual(toggle: bool):
	selectionVisual.visible = toggle
	

