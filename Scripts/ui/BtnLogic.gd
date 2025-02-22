extends TextureButton

@export var btn_text = "Placeholder"
@export var to_scene = "path://"

@onready var txt_button: RichTextLabel = $MarginContainer/TxtButton
@onready var ptc_hover: CPUParticles2D = $MarginContainer/PtcHover
@onready var snd_hover: AudioStreamPlayer2D = $MarginContainer/SndHover
@onready var snd_click: AudioStreamPlayer2D = $MarginContainer/SndClick
@onready var snd_nothing: AudioStreamPlayer2D = $MarginContainer/SndNothing
@onready var ptc_arrow: CPUParticles2D = $MarginContainer/PtcArrow

func _ready() -> void:
	txt_button.text = btn_text

func _on_pressed() -> void:
	snd_click.play()
	if to_scene != "path://":
		get_tree().change_scene_to_file(to_scene)
		ClockTimer.start()

func _on_mouse_entered() -> void:
	hoverBtn(snd_hover, true, "[shake rate=8.5 level=10 connected=1]%s[/shake]" % btn_text)

func _on_mouse_exited() -> void:
	hoverBtn(snd_nothing, false, btn_text)

func _on_focus_entered() -> void:
	hoverBtn(snd_hover, true, "[shake rate=8.5 level=10 connected=1]%s[/shake]" % btn_text)

func _on_focus_exited() -> void:
	hoverBtn(snd_nothing, false, btn_text)

func hoverBtn(sound, particle, textButton) -> void:
	sound.play()
	ptc_arrow.emitting = particle
	txt_button.text = textButton
