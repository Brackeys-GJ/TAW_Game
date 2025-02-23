extends Node

func _on_btn_exit_pressed() -> void:
	$"../MainOptions".visible = true
	$".".visible = false
