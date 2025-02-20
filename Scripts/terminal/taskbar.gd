extends Control

@export var operating_system: Node2D # Conect terminal and taskbar

@onready var window_buttons: HBoxContainer = $HBoxContainer/WindowButtons # Taskbar icons container

func _ready():
	if operating_system:
		operating_system.open_windows_updated.connect(_update_taskbar)
		for child in window_buttons.get_children():
			child.queue_free()
		
		# Create new buttons
		if operating_system:
			for window in operating_system.open_windows:
				var btn = Button.new()
				btn.text = window.get_title() if window.has_method("get_title") else "Window"
				btn.pressed.connect(_on_window_button_pressed.bind(window))
				window_buttons.add_child(btn)

func _update_taskbar():
	# Clear existing buttons
	for child in window_buttons.get_children():
		child.queue_free()
	
	# Create new buttons for each window
	for window in operating_system.open_windows:
		var btn = Button.new()
		btn.text = window.get_title() if window.has_method("get_title") else "Window"
		btn.pressed.connect(_on_window_button_pressed.bind(window))
		window_buttons.add_child(btn)

#Hiding windows when not on focus
func _on_window_button_pressed(window):
	if window.visible:
		window.hide()
	else:
		window.show()
		window.move_to_front()
