extends Node2D

var selected = false
var camera = inCamera

@export var inCamera: Camera2D

func _on_ready() -> void:
	camera = get_viewport().get_camera_2d()
	$Area2D.input_pickable = true

func _process(delta: float) -> void:
	if selected:
		# Convert screen mouse position to world coordinates through camera
		var mouse_pos = camera.get_global_mouse_position()
		global_position = lerp(global_position, mouse_pos, 25 * delta)
		print("Holding at position: ", global_position)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		selected = true
		get_viewport().set_input_as_handled()

#func _physics_process(delta: float) -> void:
	#if selected:
		#global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		#print("Holding")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			print("Let go")
