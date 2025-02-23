extends Camera2D

@export var scroll_speed: float = 10.0
@export var max_y_position: float = 750.0

func _process(delta: float) -> void:
	# Move the camera down slowly, but only if it hasn't reached the max position
	if position.y < max_y_position:
		position.y += scroll_speed * delta
	else:
		get_tree().change_scene_to_file("res://Scences/cinematics/tutorial.tscn")
