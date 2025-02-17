extends VBoxContainer

#func _ready() -> void:
	#$BtnPlay.grab_focus()

func _on_btn_options_pressed() -> void:
	$".".visible = false
	$"../Settings".visible = true
