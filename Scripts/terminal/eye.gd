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
			modulate = Color(1, 0.2, 0.2)

func _on_blink_requested():
	play("blink")

#extends AnimatedSprite2D
#
#@onready var state_timer: Timer = $StateTimer
#
#enum States { IDLE, OPEN, BLINK, MAD }
#var current_state = States.IDLE
#var previous_state: States
#var rng = RandomNumberGenerator.new()
#
#const FLOAT_AMPLITUDE = 10.0
#const FLOAT_DURATION = 2.0
#var _base_y: float
#
#func _ready():
	#rng.randomize()
	#_base_y = position.y
	#
	#if state_timer:
		#state_timer.start(5.0)
		#state_timer.timeout.connect(_on_state_timer_timeout)
	#
	#_start_floating()
#
#func _on_state_timer_timeout():
	#match current_state:
		#States.IDLE:
			#enter_idle_state()
		#States.OPEN:
			#var chance = rng.randf()
			#if chance < 0.3:
				#enter_blink_state()
			#elif chance < 0.1:
				#enter_mad_state()
			#else: 
				#enter_idle_state()
		#States.BLINK:
			## Return to previous state (open/mad)
			#if previous_state == States.OPEN:
				#enter_open_state()
			#else:
				#enter_mad_state()
		#States.MAD:
			#var chance = rng.randf()
			#if chance < 0.4: 
				#enter_blink_state()
			#else:
				#enter_idle_state()
#
#func enter_idle_state():
	#current_state = States.OPEN
	#play("idle")
	#modulate = Color.WHITE
	#state_timer.start(rng.randf_range(2.0, 4.0))
#
#func enter_open_state():
	#current_state = States.IDLE
	#play("open")
	#state_timer.start(rng.randf_range(4.0, 8.0))
#
#func enter_blink_state():
	#previous_state = current_state
	#current_state = States.BLINK
	#play("blink")
	#state_timer.start(0.2)
#
#func enter_mad_state():
	#current_state = States.MAD
	#play("mad")
	#modulate = Color(1, 0.2, 0.2)
	#state_timer.start(rng.randf_range(2.0, 4.0))
#
#func _start_floating():
	#var tween = create_tween()
	#tween.set_loops()
	#tween.set_trans(Tween.TRANS_SINE)
	#tween.set_ease(Tween.EASE_IN_OUT)
	#
	## Float animation sequence
	#tween.tween_property(self, "position:y", _base_y - FLOAT_AMPLITUDE, FLOAT_DURATION)
	#tween.tween_property(self, "position:y", _base_y + FLOAT_AMPLITUDE, FLOAT_DURATION)
