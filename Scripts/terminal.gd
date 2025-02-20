extends Node

@export var window_scene: PackedScene # Window scene
@export var taskbar: Control
var open_windows = []

signal open_windows_updated

func _ready() -> void:
	# connect signals for all the desktop apps
	for child in get_children():
		if child.has_signal("app_double_clicked"):
			child.app_double_clicked.connect(_on_app_double_clicked.bind(child))

func _on_app_double_clicked(app_node: Node):
	print(open_windows)
	var new_window = window_scene.instantiate()
	add_child(new_window)
	
	#Position window at center of camera view
	if app_node.camera:
		var viewport_size = app_node.camera.get_viewport_rect().size
		new_window.global_position = app_node.camera.global_position + viewport_size/7 - new_window.size/7
	
	# Configure window (example)
	if new_window.has_method("set_title"):
		new_window.set_title(app_node.txtFinalApp)
	
	open_windows.append(new_window)
	open_windows_updated.emit()

func _on_window_closed(window):
	#open_windows.erase(window)
	open_windows_updated.emit()
	#window.queue_free()
