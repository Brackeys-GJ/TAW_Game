extends Control

@onready var text_edit: TextEdit = $VBoxContainer/TextEdit
@onready var line_edit: LineEdit = $VBoxContainer/LineEdit

func _on_line_edit_text_submitted(new_text: String) -> void:
	text_edit.text = text_edit.text + "\n" + "> Processing..."
	if new_text == "1244":
		text_edit.text = text_edit.text + "\n" + "> Success"
	elif new_text == "Spoffy":
		text_edit.text = text_edit.text + "\n" + "> :)"
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
