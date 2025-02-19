extends Control

@onready var text_edit: TextEdit = $VBoxContainer/TextEdit

func _on_line_edit_text_submitted(new_text: String) -> void:
	text_edit.text = text_edit.text + "\n" + "> Processing..."
	if new_text == "1-2-4-4":
		text_edit.text = text_edit.text + "\n" + "> Success"
	else:
		text_edit.text = text_edit.text + "\n" + "> ERROR"
