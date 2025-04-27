extends AnimatedSprite2D

@onready var _base_y: float = position.y

const FLOAT_AMPLITUDE = 10.0
const FLOAT_DURATION = 2.0

func _ready():
	_start_floating()
	print("Connecting to: ", EyeManager.state_changed)
	EyeManager.state_changed.connect(_on_state_changed)
	EyeManager.blink_requested.connect(_on_blink_requested)
	# Initialize with current state
	_on_state_changed(EyeManager.current_state)

func _start_floating():
	var tween = create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", _base_y - FLOAT_AMPLITUDE, FLOAT_DURATION)
	tween.tween_property(self, "position:y", _base_y + FLOAT_AMPLITUDE, FLOAT_DURATION)

func _on_state_changed(new_state):
	match new_state:
		EyeManager.States.IDLE:
			play("idle")
			modulate = Color.WHITE
		EyeManager.States.OPEN:
			play("open")
		EyeManager.States.MAD:
			play("mad")
			#modulate = Color(1, 0.2, 0.2)

func _on_blink_requested():
	play("blink")
