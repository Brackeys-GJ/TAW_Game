extends Node

var step_index: int

func _ready() -> void:
	step_index = int($".".value)
	$".".value_changed.connect(_on_value_changed)
	#_on_value_changed()
	#value_changed.connect(_on_value_changed)

func _on_value_changed(value: float) -> void:
	step_index = int(value)
	print(step_index)
