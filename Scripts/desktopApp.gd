extends Node2D

var selected = false
var camera = inCamera

@export var inCamera: Camera2D # Asign the camera in the desktop
@export var txtFinalApp:String # Asign text to the app

@onready var txt_app: RichTextLabel = $TxtApp
@onready var area_app: Area2D = $AreaApp

signal app_double_clicked # To send signals to the terminal

func _on_ready() -> void:
	txt_app.text = "[center]%s[/center]" % txtFinalApp # Update text
	camera = get_viewport().get_camera_2d() # Gets camera viewport
	area_app.input_pickable = true #  Pick area node

func _process(delta: float) -> void:
	if selected:
		# Convert screen mouse position to terminal coordinates through camera
		var mouse_pos = camera.get_global_mouse_position()
		global_position = lerp(global_position, mouse_pos, 25 * delta)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			# Open app logic
			if event.pressed and event.double_click:
				emit_signal("app_double_clicked")
				get_viewport().set_input_as_handled()
			# Move app logic
			elif event.pressed:
				selected = true
				get_viewport().set_input_as_handled()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		# Release app (stop moving when stop holding mouse)
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
