extends RichTextLabel

@export var input: String
@export var typing_speed = 0.1  # Seconds per character
@export var word_pause = 0.1 # Pause between words
@export var next_scene_path: String

var words = []
var current_word_index = 0
var is_waiting_for_click = false
var is_text_finished = false

func _ready():
	text = ""
	words = input.split(" ")
	start_typing()

func start_typing():
	if current_word_index >= words.size():
		is_text_finished = true
		return
	
	var current_word = words[current_word_index]
	
	# Check for the pause character "|"
	if current_word == "|":
		is_waiting_for_click = true
		current_word_index += 1
		return
	
	var tagged_word = "[shake rate=8.5 level=10 connected=1]%s[/shake]]" % current_word
	
	if current_word_index > 0:
		append_text(" ")
	append_text("[shake rate=8.5 level=10]%s[/shake]" % current_word)
	
	# Animate characters
	var base_length = get_total_character_count()
	for i in range(self.visible_characters + 1, base_length + 1):
		self.visible_characters = i
		await get_tree().create_timer(typing_speed).timeout
	
	var current_text = get_parsed_text()
	var new_text = current_text.replace(tagged_word, current_word)
	self.text = new_text
	
	current_word_index += 1
	await get_tree().create_timer(word_pause).timeout
	start_typing()


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if is_waiting_for_click:
			# Continue typing after click
			is_waiting_for_click = false
			get_viewport().set_input_as_handled()  # Mark the input as handled
			text = ""  # Clear the textbox before continuing
			start_typing()
		elif is_text_finished:
			# Change scene after click
			get_viewport().set_input_as_handled()  # Mark the input as handled
			get_tree().change_scene_to_file(next_scene_path)
