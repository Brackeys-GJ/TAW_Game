extends Control

@export var CinPlayer: AnimationPlayer

func _ready() -> void:
	CinPlayer.play("CinematicPlay")
