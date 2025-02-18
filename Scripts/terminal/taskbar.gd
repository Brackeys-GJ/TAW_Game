extends Node

@export var window_scene: PackedScene
@export var taskbar: Control
var open_windows = []

signal open_windows_updated

func _ready() -> void:
	for child in get_children():
		if child.has_signal("app_double_clicked"):
			child.app_double_clicked.connect(_on_app_double_clicked)

func _on_app_double_clicked(app_node: Node):
	var new_window = window_scene.instantiate()
	add_child(new_window)
	
	# Set window properties
	new_window.title = app_node.txtFinalApp
	new_window.close_requested.connect(_on_window_closed.bind(new_window))
	
	open_windows.append(new_window)
	open_windows_updated.emit()

func _on_window_closed(window):
	open_windows.erase(window)
	open_windows_updated.emit()
	window.queue_free()

#func _process(delta):
	##Update clock
	#$Panel/HBoxContainer/SystemTray/ClockLabel.text = Time.get
	#Time.get_time_string_from_system()

#func _on_start_button_pressed():
	## Show start menu (create this as another scene)
	#var start_menu = preload("res://StartMenu.tscn").instantiate()
	#add_child(start_menu)
	#start_menu.position = Vector2(start_button.global_position.x, start_button.global_position.y - start_menu.size.y)
