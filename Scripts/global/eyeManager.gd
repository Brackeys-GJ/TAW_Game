extends Node

signal state_changed(new_state)
signal blink_requested()

enum States { IDLE, OPEN, BLINK, MAD }
var current_state = States.IDLE
var previous_state: States
var rng = RandomNumberGenerator.new()

var _state_timer: Timer

func _ready():
	rng.randomize()
	_state_timer = Timer.new()
	add_child(_state_timer)
	_state_timer.autostart = true
	_state_timer.timeout.connect(_update_state)
	start_state_cycle()

func start_state_cycle():
	current_state = States.IDLE
	_state_timer.start(5.0)
	
func _update_state():
	# Your existing state logic here
	match current_state:
		States.IDLE:
			current_state = States.OPEN
			state_changed.emit(current_state)
			_state_timer.start(rng.randf_range(2.0, 4.0))
		States.OPEN:
			var chance = rng.randf()
			if chance < 0.3:
				previous_state = current_state
				current_state = States.BLINK
				blink_requested.emit()
				_state_timer.start(0.2)
			elif chance < 0.4:  # 0.3-0.4 range (10% total)
				current_state = States.MAD
				state_changed.emit(current_state)
				_state_timer.start(rng.randf_range(2.0, 4.0))
			else:
				current_state = States.IDLE
				state_changed.emit(current_state)
				_state_timer.start(rng.randf_range(4.0, 8.0))
		States.BLINK:
			current_state = previous_state
			state_changed.emit(current_state)
			_state_timer.start(rng.randf_range(
				2.0 if current_state == States.MAD else 4.0, 
				4.0 if current_state == States.MAD else 8.0
			))
		States.MAD:
			mad_minigame()
			var chance = rng.randf()
			if chance < 0.4:
				previous_state = current_state
				current_state = States.BLINK
				blink_requested.emit()
				_state_timer.start(0.2)
			else:
				current_state = States.IDLE
				state_changed.emit(current_state)
				_state_timer.start(rng.randf_range(4.0, 8.0))

func mad_minigame():
	var Num = randi_range(1,2)
	if Num == 1:
		States.BLINK
	else:
		get_tree().quit()
