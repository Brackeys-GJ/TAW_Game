extends Camera2D

@export var scroll_speed: float
@export var max_y_position: float

@export var Text: Control

func _process(delta: float) -> void:
	# Move the camera down slowly, but only if it hasn't reached the max position
	if position.y < max_y_position:
		position.y += scroll_speed * delta
		Text.position.y = position.y
	else:
		get_tree().change_scene_to_file("res://Scences/cinematics/tutorial.tscn")
