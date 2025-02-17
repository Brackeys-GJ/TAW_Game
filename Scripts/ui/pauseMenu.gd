extends Control

func _on_ready() -> void:
	$".".visible = false

func _process(delta):
	pressEsc()

func pause():
	#get_tree().paused = true
	$".".visible = true

func resume():
	get_tree().paused = false
	$".".visible = false

func pressEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()

func _on_btn_resume_focus_entered() -> void:
	resume()


func _on_btn_main_menu_focus_entered() -> void:
	get_tree().change_scene_to_file("res://Scences/ui/mainMenu.tscn")
