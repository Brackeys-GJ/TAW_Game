extends Node

signal state_changed(new_state)
signal blink_requested()
signal health_changed(new_health)

enum States { IDLE, OPEN, BLINK, MAD }
var current_state = States.IDLE
var previous_state: States
var rng = RandomNumberGenerator.new()

var _state_timer: Timer
var health: int = 3
var last_mouse_position: Vector2
var last_input_time: float

const MAD_DURATION = 5.0
const INPUT_CHECK_INTERVAL = .1
const HEALTH_PENALTY = 1

func start():
	rng.randomize()
	_state_timer = Timer.new()
	add_child(_state_timer)
	_state_timer.autostart = true
	_state_timer.timeout.connect(_update_state)
	start_state_cycle()
	
	last_mouse_position = get_viewport().get_mouse_position()
	last_input_time = Time.get_ticks_msec()
	set_process(true)

func _process(delta):
	if current_state == States.MAD:
		check_player_input()

func start_state_cycle():
	current_state = States.IDLE
	_state_timer.start(5.0)
	
func _update_state():
	match current_state:
		States.IDLE:
			current_state = States.OPEN
			state_changed.emit(current_state)
			_state_timer.start(rng.randf_range(2.0, 4.0))
		States.OPEN:
			var chance = rng.randf()
			if chance < 0.3:
				enter_blink_state()
			elif chance < 0.4:
				enter_mad_state()
			else:
				enter_idle_state()
		States.BLINK:
			current_state = previous_state
			state_changed.emit(current_state)
			_state_timer.start(rng.randf_range(
				2.0 if current_state == States.MAD else 4.0, 
				4.0 if current_state == States.MAD else 8.0
			))
		States.MAD:
			var chance = rng.randf()
			if chance < 0.4:
				enter_blink_state()
			else:
				enter_idle_state()

func enter_blink_state():
	previous_state = current_state
	current_state = States.BLINK
	blink_requested.emit()
	_state_timer.start(0.2)

func enter_mad_state():
	current_state = States.MAD
	state_changed.emit(current_state)
	_state_timer.start(MAD_DURATION)
	# Reset tracking for mad state
	last_mouse_position = get_viewport().get_mouse_position()
	last_input_time = Time.get_ticks_msec()

func enter_idle_state():
	current_state = States.IDLE
	state_changed.emit(current_state)
	_state_timer.start(rng.randf_range(4.0, 8.0))

func check_player_input():
	var current_time = Time.get_ticks_msec()
	# Check mouse movement
	var current_mouse_pos = get_viewport().get_mouse_position()
	if current_mouse_pos != last_mouse_position:
		apply_health_penalty()
		last_mouse_position = current_mouse_pos
	# Check keyboard input
	if Input.is_anything_pressed():
		apply_health_penalty()
	# Update last check time
	last_input_time = current_time

func apply_health_penalty():
	HealthManager.current_health -= HEALTH_PENALTY

func game_over():
	print("Game Over!")
	HealthManager.emit_signal("game_over")  # Delegate to HealthManager
	get_tree().change_scene_to_file("res://Scences/cinematics/GameOver.tscn")
