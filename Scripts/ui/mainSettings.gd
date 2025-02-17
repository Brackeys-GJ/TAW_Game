extends HBoxContainer

func _ready() -> void:
	pass # Replace with function body.

func _on_btn_exit_pressed() -> void:
	$"../MainOptions".visible = true
	$".".visible = false
