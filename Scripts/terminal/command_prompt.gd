extends Control

@onready var text_edit: TextEdit = $VBoxContainer/TextEdit

var EditingText = false

func _on_text_edit_text_changed() -> void:
	EditingText = true

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("enter") and EditingText:
		text_edit.text = text_edit.text + "\n" + "> Processing..."
