# health_manager.gd
extends Node

signal health_changed(new_health)
signal game_over()

var current_health: int = 100:
	set(value):
		current_health = clampi(value, 0, 100)
		if current_health <= 0:
			game_over.emit()
			#get_tree().quit()

func reset_health():
	current_health = 3
