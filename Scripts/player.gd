extends CharacterBody2D


const Speed = 300.0
const JumpVelocity = -400.0


func _physics_process(delta: float) -> void:
	#Movement:
	var XDirection := Input.get_axis("move_left", "move_right")
	var YDirection := Input.get_axis("move_up", "move_down")
	if XDirection:
		velocity.x = XDirection * Speed
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)
		
	if YDirection:
		velocity.y = YDirection * Speed
	else:
		velocity.y = move_toward(velocity.y, 0, Speed)

	move_and_slide()
