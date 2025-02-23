extends Node

@onready var label: Label = $"."


func _ready() -> void:
	label.text = "♡" + str(HealthManager.current_health)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "♡" + str(HealthManager.current_health)
