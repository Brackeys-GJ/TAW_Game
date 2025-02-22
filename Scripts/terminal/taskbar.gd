extends Control

@export var operating_system: Control # Conect terminal and taskbar

@onready var window_buttons: HBoxContainer = $HBoxContainer/WindowButtons # Taskbar icons container
@onready var app_files: Node2D = $"../../AppFiles"
@onready var app_command_prompt: Node2D = $"../../AppCommandPrompt"
@onready var app_prisoner_sorting: Node2D = $"../../AppPrisonerSorting"

@onready var ClockLevel: Label = %ClockLevel
@onready var Date: Label = %Date

func _ready():
	UpdateClock(ClockTimer.ClockLevel)
	if operating_system:
		operating_system.open_windows_updated.connect(open_windows_updated)
		open_windows_updated()

func open_windows_updated():
	# Clear existing buttons
	for child in window_buttons.get_children():
		child.queue_free()
	
	# Create new buttons for each window
	for window in operating_system.open_windows:
		if not is_instance_valid(window):
			continue
		
		var btn = TextureRect.new()
		btn.expand_mode = TextureRect.EXPAND_FIT_WIDTH
		btn.texture = window.app_icon  # Directly access the app_icon from the window
		btn.gui_input.connect(_on_window_button_pressed.bind(window))
		window_buttons.add_child(btn)

#Hiding windows when not on focus
func _on_window_button_pressed(event: InputEvent, window: Node):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			# Toggle window visibility
			if window.visible:
				window.hide()
			else:
				window.show()
				window.move_to_front()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			# Close window completely
			operating_system.remove_window(window)
			window.queue_free()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scences/terminal/terminal.tscn")

func UpdateClock(NewTime):
	ClockLevel.text = NewTime
