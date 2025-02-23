# health_manager.gd
extends Node

signal health_changed(new_health)
signal game_over()

var current_health: int = 100:
	set(value):
		current_health = clampi(value, 0, 100)
		if current_health <= 1:
			get_tree().change_scene_to_file("res://Scences/cinematics/GameOver.tscn")
			reset_health()
			game_over.emit()

func reset_health():
	current_health = 100
