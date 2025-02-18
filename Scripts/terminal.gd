extends Node

@export var window_scene: PackedScene # Window scene
var open_windows = []

func _ready() -> void:
	# connect signals for all the desktop apps
	for child in get_children():
		if child.has_signal("app_double_clicked"):
			child.app_double_clicked.connect(_on_app_double_clicked.bind(child))

func _on_app_double_clicked(app_node: Node):
	var new_window = window_scene.instantiate()
	add_child(new_window)
	
	#Position window at center of camera view
	if app_node.camera:
		var viewport_size = app_node.camera.get_viewport_rect().size
		new_window.global_position = app_node.camera.global_position + viewport_size/2 - new_window.size/2
	
	# Configure window (example)
	if new_window.has_method("set_title"):
		new_window.set_title(app_node.txtFinalApp)
	
	open_windows.append(new_window)

func _on_area_app_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass  # Keep this if you need it for other interactions
