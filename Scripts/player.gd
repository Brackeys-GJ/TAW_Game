extends CharacterBody2D

#Constant Variables
const Speed = 150.0
const JumpVelocity = -400.0

#Functions
func _physics_process(_delta: float) -> void:
	#X Axis Movement
	var XDirection := Input.get_axis("move_left", "move_right")
	
	if XDirection:
		velocity.x = XDirection * Speed
		
		#Sprint Check
		if Input.is_action_pressed("sprint"):
			velocity.x = velocity.x * 1.5
			
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)
	
	#Y Axis Movement
	var YDirection := Input.get_axis("move_up", "move_down")
	
	if YDirection:
		velocity.y = YDirection * Speed
		
		#Sprint Check
		if Input.is_action_pressed("sprint"):
			velocity.y = velocity.y * 1.5
			
	else:
		velocity.y = move_toward(velocity.y, 0, Speed)
	
	#Apply Movement
	move_and_slide()
