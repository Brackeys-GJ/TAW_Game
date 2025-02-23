extends Node

func _on_gui_input(event: InputEvent) -> void:
	get_tree().change_scene_to_file("res://Scences/terminal/terminal.tscn")
