extends Control

@onready var text_edit: TextEdit
@onready var line_edit: LineEdit

var drag_offset = Vector2.ZERO
var dragging = false
var window_title := "New Window"

signal close_requested

#func _ready():
	#line_edit.text_submitted.connect(_on_line_edit_text_submitted)

func _on_line_edit_text_submitted(new_text: String) -> void:
	text_edit = $VBoxContainer/TextEdit
	line_edit = $VBoxContainer/LineEdit
	text_edit.text = text_edit.text + "\n" + "> Processing..."
	if new_text == "1244":
		text_edit.text = text_edit.text + "\n" + "> Success"
	elif new_text == "Spoffy":
		text_edit.text = text_edit.text + "\n" + "> :)"
	elif new_text == "Creeper":
		text_edit.text = text_edit.text + "\n" + "> Playing Audio..."
		$Creeper.play()
	elif new_text == "Link":
		text_edit.text = text_edit.text + "\n" + "> Playing Audio..."
		$Link.play()
	elif new_text == "Mouse Link":
		text_edit.text = text_edit.text + "\n" + "> Playing Audio..."
		$MouseLink.play()
	elif new_text == "????":
		text_edit.text = text_edit.text + "\n" + "> Playing Audio..."
		$"AudioFile#1".play()
	elif new_text == "":
		pass
	else:
		text_edit.text = text_edit.text + "\n" + "> ERROR"
	line_edit.clear()

var Fullscreen = false

func _on_button_pressed(BtnFunc: int) -> void:
	if BtnFunc == 1:
		visible = false
	elif BtnFunc == 2:
		pass
	elif BtnFunc == 3:
		queue_free()

# Dragging window
func _on_h_box_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.pressed
		drag_offset = get_global_mouse_position() - position
	elif event is InputEventMouseMotion and dragging:
		position = get_global_mouse_position() - drag_offset
		

func set_title(title: String):
	window_title = title
	# Update title label if exists
	if has_node("$VBoxContainer/HBoxContainer/Label"):
		$TitleBar/Label.text = title

func _on_close_button_pressed():
	emit_signal("close_requested")
