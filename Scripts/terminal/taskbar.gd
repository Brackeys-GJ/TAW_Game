extends Control

@export var operating_system: Control # Conect terminal and taskbar

@onready var window_buttons: HBoxContainer = $HBoxContainer/WindowButtons # Taskbar icons container
@onready var app_files: Node2D = $"../../AppFiles"
@onready var app_command_prompt: Node2D = $"../../AppCommandPrompt"
@onready var app_prisoner_sorting: Node2D = $"../../AppPrisonerSorting"


@onready var clock_timer: Timer = $ClockTimer
@onready var time: Label = %Time
@onready var date: Label = %Date

var Hour = 12
var Min = 00

var month = 4
var day = 5
var year = 2060

func _ready():
	#StartClock()
	if operating_system:
		operating_system.open_windows_updated.connect(_update_taskbar)
		_update_taskbar()

func _update_taskbar():
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

#func StartClock():
	#if Min < 10:
		#time.text = str(Hour) + ":0" + str(Min)
	#else:
		#time.text = str(Hour) + ":" + str(Min)
	#clock_timer.start()

func _on_date_timeout() -> void:
	if Min == 60:
		Hour = Hour + 1
		Min = 0
	else:
		Min = Min + 1
	if Hour == 24:
		day = day + 1
		Min = 0
		Hour = 1
		date.text = str(month) + "/" + str(day) + "/" + str(year)
	#StartClock()
