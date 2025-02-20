extends Node

@export var terminal: Node # Conect terminal and taskbar

@onready var window_buttons: HBoxContainer = $HBoxContainer/WindowButtons # Taskbar icons container

func _ready():
	#Recieves the signal from the terminal
	terminal.open_windows_updated.connect(_update_taskbar)
	#pass

func _update_taskbar():
	# Clear existing buttons
	for child in window_buttons.get_children():
		print("HELLo")
		child.queue_free()
	
	# Create new buttons for each window
	for window in terminal.open_windows:
		var btn = Button.new()
		btn.text = "New tab"
		btn.pressed.connect(_on_window_button_pressed.bind(window))
		window_buttons.add_child(btn)

#Hiding windows when not on focus
func _on_window_button_pressed(window):
	if window.visible:
		window.hide()
	else:
		window.show()
		window.move_to_front()
