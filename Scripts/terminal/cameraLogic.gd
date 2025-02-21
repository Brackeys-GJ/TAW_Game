extends Camera2D

# Base resolution your game is designed for
#var base_viewport_size := Vector2(1920, 1080)
var base_viewport_size := Vector2(1152, 648)

func _ready():
	get_viewport().connect("size_changed", _on_viewport_resize)
	_on_viewport_resize() # Initial call

func _on_viewport_resize():
	var current_size = get_viewport().size
	# Calculate zoom to maintain base aspect ratio
	var zoom_x = current_size.x / base_viewport_size.x
	var zoom_y = current_size.y / base_viewport_size.y
	zoom = Vector2(zoom_x, zoom_y)
