extends AnimatedSprite2D

# Declare the timer
@onready var state_timer: Timer = $StateTimer

# Declare the states
enum States { IDLE, BLINK, MAD }
var current_state = States.IDLE

const FLOAT_AMPLITUDE = 10.0
const FLOAT_DURATION = 2.0
var _base_y: float

func _ready():
	# Start the timer when the scene is ready
	if state_timer:
		state_timer.start(5.0)
		state_timer.timeout.connect(_on_state_timer_timeout)
	else:
		print("Timer not available")
	
	_start_floating()

func _on_state_timer_timeout():
	# Toggle the state
	match current_state:
		States.IDLE:
			current_state = States.BLINK
			play("idle")
			modulate = Color.WHITE
			state_timer.start(5.0)
		States.BLINK:
			current_state = States.MAD
			play("blink")
			modulate = Color.WHITE
			state_timer.start(0.2)
		States.MAD:
			current_state = States.IDLE
			play("mad")
			modulate = Color(1, 0.2, 0.2)
			state_timer.start(5.0)

func _start_floating():
	# Create and configure tween
	var tween = create_tween()
	tween.set_loops()  # Infinite loops by default
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	# Float animation sequence
	tween.tween_property(self, "position:y", _base_y - FLOAT_AMPLITUDE, FLOAT_DURATION)
	tween.tween_property(self, "position:y", _base_y + FLOAT_AMPLITUDE, FLOAT_DURATION)
	tween.tween_property(self, "position:y", _base_y, FLOAT_DURATION)
