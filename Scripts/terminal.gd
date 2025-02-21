extends Control

@export var taskbar: Control
var open_windows = []

signal open_windows_updated

func _ready() -> void:
	for child in get_children():
		if child is Node2D and child.has_signal("app_double_clicked"):
			child.app_double_clicked.connect(_on_app_double_clicked)

func _on_app_double_clicked(content_scene: PackedScene, app_name: String):
	var new_window = content_scene.instantiate()
	$WindowLogic/Control.add_child(new_window)
	new_window.show()
	
	if new_window is Control:
		new_window.move_to_front()
	elif new_window is Node2D:
		new_window.z_index = 100
	
	if new_window.has_method("set_title"):
		new_window.set_title(app_name)
	
	new_window.position = Vector2(500, 400) + Vector2(open_windows.size() * 10, open_windows.size() * 30)
	open_windows.append(new_window)
	open_windows_updated.emit()
	
	if new_window.has_signal("close_requested"):
		new_window.connect("close_requested", _on_window_closed.bind(new_window))

func _on_window_closed(window):
	open_windows.erase(window)
	open_windows_updated.emit()
	window.queue_free()
