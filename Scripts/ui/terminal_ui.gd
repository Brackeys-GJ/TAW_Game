extends Control

@onready var snd_click: AudioStreamPlayer2D = $SndClick

func _ready() -> void:
	EyeManager.start()

var buttons_on = {
	1: false,
	2: false,
	3: false,
	4: false,
	5: false}

func _on_button_toggled(toggled_on: bool, button_num: int) -> void:
	if toggled_on:
		buttons_on[button_num] = true
		$SfxSwitchOn.play()
		if buttons_on[1] and buttons_on[2] and buttons_on[3] and buttons_on[4] and buttons_on[5]:
			get_tree().change_scene_to_file("res://Scences/terminal/operatingsystem/operatingsystem.tscn")
	else:
		buttons_on[button_num] = false
		$SfxSwitchOff.play()
