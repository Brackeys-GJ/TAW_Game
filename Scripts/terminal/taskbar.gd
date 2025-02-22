extends Control

@export var operating_system: Control # Conect terminal and taskbar

@onready var window_buttons: HBoxContainer = $HBoxContainer/WindowButtons # Taskbar icons container

@onready var clock_timer: Timer = $ClockTimer
@onready var time: Label = %Time
@onready var date: Label = %Date

var Hour = 23
var Min = 59

var month = 4
var day = 5
var year = 2060

func _ready():
	StartClock()
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

func StartClock():
	if Min < 10:
		time.text = str(Hour) + ":0" + str(Min)
	else:
		time.text = str(Hour) + ":" + str(Min)
	clock_timer.start()

func _on_date_timeout() -> void:
	if Min == 59:
		Hour = Hour + 1
		Min = 0
	else:
		Min = Min + 1
	if Hour == 24:
		day = day + 1
		var CurrentDate = str(month) + "/" + str(day) + "/" + str(year)
		date.text = CurrentDate
		Min = 0
		Hour = 1
	StartClock()
