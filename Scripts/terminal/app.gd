extends Control
#Preloading Templates
const FILESTEMPLATE = preload("res://Scences/terminal/filesapp/filestemplate.tscn")
const FOLDERTEMPLATE = preload("res://Scences/terminal/filesapp/foldertemplate.tscn")

@onready var FileBox: VBoxContainer
@onready var FolderBox: VBoxContainer
@onready var PopUpMenu: Panel
@onready var Filepath: Label
@onready var UpdateDelay: Timer
@onready var Receiver: OptionButton

@export var app_icon: Texture2D

var FileTypes = {
	1: "Text",
	2: "Image",
	3: "Application",
	}

var StartingFiles = {
	#FORMAT: Key: ["Name", Filetype, Folder(If none set: 0)],
	1: ["📁  Files", 3, 1],
	2: ["💿  Command Prompt", 3, 1],
	}

var StartingFilesAmount = len(StartingFiles)

var StartingFolders = {
	#FORMAT: Key: "Name",
	1: "Desktop",
	2: "Downloads",
	3: "Documents",
	4: "Gallery"
	}

@onready var text_edit: TextEdit
@onready var line_edit: LineEdit

# To drag window on OS
var drag_offset = Vector2.ZERO
var dragging = false
var window_title := "New Window"

signal close_requested

@export var App: int

@onready var FirstnameChange: Label
var FristNames = [
	"Yuri",
	"Mikhail",
	"Ingrid",
	"Viktor",
	"Daniel",
	"Harriet",
	"Sigrid",
	"Gennady",
	"Francis",
	"Helmut",
	"Walter",
	"Sylvia",
	"Vera",
	"László",
	"Nikolae",
	"Oleg",
	"Joe",
	]
@onready var SurnameChange: Label
var Surnames = [
	"Volkov",
	"Sokolov",
	"Koenig",
	"Petrov",
	"Harrington",
	"Cromwell",
	"Müller",
	"Lebedev",
	"Delacroix",
	"Fischer",
	"Braun",
	"Hastings",
	"Jovanovic",
	"Farkas",
	"Preda",
	"Kozlov",
	"Vaklrm",
	]
@onready var DOBChange: Label
@onready var AccusationChange: Label
var Accusations = {
	1: ["Subversive speech", 3],
	2: ["Unauthorized assembly", 1],
	3: ["Aiding foreign agents", 4],
	4: ["Anti-Watcher sentiment", 3],
	5: ["Undermining state moral", 1],
	6: ["Sabotage", 2],
	7: ["Theft", 1],
	8: ["Bribery/Corruption", 1],
	9: ["Counterfeiting ration tickets", 3],
	10: ["Counterfeiting papers", 4],
	11: ["Indecent behavior", 3],
	12: ["Disrupting public order", 3],
	13: ["Murder", 2],
	14: ["Disobedience to orders", 2],
	15: ["Dereliction of duty", 2],
	16: ["Lack of discipline", 4],
	17: ["Prohibited use of resources", 1],
	18: ["Desertion", 2],
	}
@onready var IDChange: Label
@onready var NationalityChange: Label
var Nationalities = {
	1: ["American","Argentine", "Australian", "Austrian"],
	2: ["Belgian","Brazilian","British"],
	3: ["Canadian","Chinese","Cuban"],
	4: ["Danish","Dutch"],
	5: ["Egyptian","English"],
	6: ["French","Filipino"],
	7: ["German","Greek"],
	8: ["Hungarian"],
	9: ["Indian","Irish","Italian"],
	10: ["Japanese"],
	11: ["Kenyan"],
	12: ["Libyan", "Latvian"],
	13: ["Mexican","Mongolian"],
	14: ["New Zealander", "Norwegian"],
	15: ["Palestinian", "Polish"],
	16: ["Romanian", "Russian"],
	17: ["Scottish","South African", "Spanish", "Swedish", "Syrian"],
	18: ["Taiwanese", "Turkish"],
	19: ["Ukrainian"],
	20: ["Vietnamese"],
	21: ["Welsh"],
	}
@onready var AgeChange: Label
@onready var HeightChange: Label
@onready var WeightChange: Label
@onready var FacesChange: Label
@onready var PORChange: Label
#Files Buttons
@onready var CutButton: TextureButton
@onready var CopyButton: TextureButton
@onready var EditButton: TextureButton
@onready var SendButton: TextureButton
@onready var TrashButton: TextureButton
#Prisoner Info Fills
@onready var FacilityDropdown: OptionButton
@onready var AdultCheck: CheckBox
@onready var JuvieCheck: CheckBox
@onready var PrisonTermEdit: LineEdit
@onready var IDEdit: LineEdit
#Prisoner Image Assets
@onready var Head: TextureRect
@onready var Hair: TextureRect
@onready var Eyes: TextureRect
@onready var Mouth: TextureRect
@onready var Nose: TextureRect
#Emails
@onready var Emails: VBoxContainer

var PossibleEmails = {
	#FORMAT: Key: ["Name","Sender","Body1","Body2","Body3"]
	1: ["Welcome to Burea-a-Corp!", "Watchers",
	"Welcome to your new position at Burea-a-Corp! You will be tasked with ensuring that the United States of America runs ",
	"at peak efficiency and safety in the age of our new rulers! These task may consist of: Management of military and civilian ",
	"logistics, prisoner sorting, and many more! And always remember… They are always Watching…"],
	2: ["Unica Spes", "Cipher",
	"This is Cipher. I will be your contact from now on. You are insane for even considering doing this.",
	"You have five days to send us as much intel as possible and disrupt Watcher logistics.",
	"Hell if you can send some of the goods to us. Do whatever you can. Just don’t get yourself killed"],
	3: ["Prisoner Duty","Watchers",
	"The Oculus has round up some new prisoners. See that they are sorted properly."],
	4: ["Prisoner Duty","Watchers",
	"The Watchers have noticed some discrepancies in your sorting. For your sake lets ensure that this doesn’t happen with this batch."],
	5: ["Mistake email", "Watchers", "#6512595-A"],
	#Above Goal Emails
	6: ["Day 1", "Cipher",
	"The intel you sent saved a lot of lives. Thank you. We are still far from our goal, but just everyday we get closer to freedom"],
	7: ["Day 2", "Cipher",
	"We are starting to coordinate our moves against the watchers. You have freed many of us and caused some major blows to the",
	"Watchers logistics. Remember to stay low, they are bound to get on to the fact that they have a rat on the inside."],
	8: ["Day 3", "Cipher",
	"I used to not think about it, but I am starting to remember life before the Watchers. Our offensive is starting to",
	"take shape, and I can’t help thinking about the world as it was. This is all thanks to you",
	"and your efforts. You are bound to be in the history books my friend"],
	9: ["Day 4", "Cipher",
	"The offensive is all planned out, we just need to rest of the resources and personnel to make it happen.",
	"It is up to you today. Your place is our first stop. We are gonna break",
	"you out along with of those the Watchers have enslaved"],
	10: ["Day 5", "Cipher",
	"You might as well pack up the desk, you won’t be doing much work today. Just make sure once you hear a few",
	"bangs just duck down for us and we will take care of the rest. You will be debriefed once we secure the",
	"building. You did some great work back there; you deserve some rest once this is all over"],
	#Below Goal Emails
	11: ["Day 1", "Cipher",
	"Yesterday didn’t go as planned. We still have 4 days but everyday counts. Lets make today a good one"],
	12: ["Day 2", "Cipher",
	"There is a growing fear that the Watchers may be zeroing in on us. We are not nearly as strong as we",
	"would like to be. Humanity needs you to really pull through these next few days. Don’t let us down"],
	13: ["Day 3", "Cipher",
	"Things are not looking good here. Our raids on Watcher positions have ended in disaster, it is like they are predicting our every",
	"move. Look, I now risking your life doesn’t sound like the greatest thing to do, but when humanity is on the brink of permanent",
	"enslavement. All I am saying is lets think a bit more about the big picture here"],
	14: ["Day 4", "Anders Coleman",
	"This is General Anders Coleman of the North American Resistance. Cipher is dead. The Watchers know where we are. It is only a",
	"matter of time before they strike. It would take a miracle to save us. Today I need you to be a soldier. Many of my men have",
	"died over the past week, maker sure it isn’t for nothing"],
	15: ["Day 5", "Anders Coleman",
	"They have breached the west wall. They are even in the tunnels. The courtyard is has been overrun and all exits are cut off.",
	"We cannot get out.",
	"They were always Watching…"],
	}

var EmailAmount = len(PossibleEmails)

#On Ready
func _ready() -> void:
	if App == 1:
		FileBox = %FileBox
		FolderBox = %FolderBox
		CutButton = %CutButton
		CopyButton = %CopyButton
		EditButton = %EditButton
		SendButton = %SendButton
		TrashButton = %TrashButton
		PopUpMenu = %PopUpMenu
		Filepath = %Filepath
		UpdateDelay = $UpdateDelay
		Receiver = %Receiver
		UpdateDelay.start()
		for I in range(1,5):
			MakeFolder(StartingFolders[I])
		for I in range(1,2 + 1):
			GameManager.Files[I] = []
			print(GameManager.Files[I])
			MakeFile(I, StartingFiles[I][0], StartingFiles[I][1], StartingFiles[I][2])
	elif App == 2:
		text_edit = $VBoxContainer/TextEdit
		line_edit = $VBoxContainer/LineEdit
	elif App == 3:
		FirstnameChange = %FirstnameChange
		SurnameChange = %SurnameChange
		DOBChange = %DOBChange
		AccusationChange = %AccusationChange
		IDChange = %IDChange
		NationalityChange = %NationalityChange
		AgeChange = %AgeChange
		HeightChange = %HeightChange
		WeightChange = %WeightChange
		FacesChange = %FacesChange
		PORChange = %PORChange
		FacilityDropdown  = %FacilityDropdown
		AdultCheck = %AdultCheck
		JuvieCheck = %JuvieCheck
		PrisonTermEdit = %PrisonTermEdit
		IDEdit = %IDEdit
		Head = %Head
		Hair = %Hair
		Eyes = %Eyes
		Mouth = %Mouth
		Nose = %Nose
		ChangePrisonerInfo()
	elif App == 4:
		Emails = %Emails
		GameManager.EmailBox = Emails
		for I in range(1, len(PossibleEmails) + 1):
			GameManager.Emails[I] = PossibleEmails[I]
		for I in range(1,3):
			GameManager.MakeEmail(I, PossibleEmails)

func _on_update_delay_timeout() -> void:
	for I in range(1, len(GameManager.FilesNeedAdded)+1):
		AddFiles(GameManager.FilesNeedAdded[0])

func MakeFile(Filepath: int, FileName: String, Filetype: int, Folder: int):
		#Getting File Instance
		var Instance = FILESTEMPLATE.instantiate()
		#Getting File Info As Vars
		var FileNameLabel = Instance.get_child(0).get_child(0).get_child(0)
		var FileDateLabel = Instance.get_child(0).get_child(0).get_child(1)
		var FiletypeLabel = Instance.get_child(0).get_child(0).get_child(2)
		
		#Setting File Info
		FileNameLabel.text = FileName
		FileDateLabel.text = ClockTimer.CurrentDate
		FiletypeLabel.text = FileTypes[Filetype]
		Instance.name = FileName
		
		GameManager.Files[Filepath] = [FileName, Filetype, Folder]
		print("Files" + str(GameManager.Files))
		
		GameManager.FilesNeedAdded.append(Instance)
		print("FilesNeedAdded" + str(GameManager.FilesNeedAdded))

func AddFiles(File):
	FileBox.add_child(File)
	var FileButton: Button = File.get_child(0)
	FileButton.pressed.connect(Callable(_file_toggled).bind(File.name))
	GameManager.FilesNeedAdded.erase(File)

func MakeFolder(FolderName: String):
	#Getting Folder Instance
	var Instance = FOLDERTEMPLATE.instantiate()
	#Getting Folder Info As Vars
	var FolderNameText = Instance.get_child(0)
	#Setting Folder Info
	FolderNameText.text = "📁  " + FolderName
	Instance.name = FolderName
	#Adding As child of FolderBox
	FolderBox.add_child(Instance)

var AccusationsNum = 0

func ChangePrisonerInfo():
	#Prisoner Image
	var PNG = ".PNG"
	var HeadPath = "res://Assets/images/prisoners/Face Parts/Head "
	var HairPath = "res://Assets/images/prisoners/Face Parts/Hair "
	var EyePath = "res://Assets/images/prisoners/Face Parts/Eyes "
	var MouthPath = "res://Assets/images/prisoners/Face Parts/Mouth "
	var NosePath = "res://Assets/images/prisoners/Face Parts/Nose "
	
	var Num = 0
	
	var ImageAccess = {
		1: [Head,HeadPath],
		2: [Hair,HairPath],
		3: [Eyes,EyePath],
		4: [Mouth,MouthPath],
		5: [Nose,NosePath],
	}

	for I in range(1,6):
		Num = randi_range(1,4)
		ImageAccess[I][0].texture = load(ImageAccess[I][1] + str(Num) + PNG)
	
	#First Name
	FirstnameChange.text = "}: " + FristNames.pick_random()
	#Surname
	SurnameChange.text = "}: " + Surnames.pick_random()
	#Date of Birth
	var month = randi_range(1,12)
	
	var max_day = 0
	if month == 2:
		max_day = 28
	elif month == 1 or 3 or 5 or 7 or 8 or 10 or 12:
		max_day = 31
	else:
		max_day = 30
		
	if month <= 10:
		month = "0" + str(month)
	else:
		month = str(month)
	
	var day = str(randi_range(1,max_day))
	var year = randi_range(2020, 2045)
	var date = month + "." + day + "." + str(year)
	
	DOBChange.text = "}: " + date
	#Accusation
	AccusationsNum = randi_range(1,18)
	AccusationChange.text = "}: " + Accusations[AccusationsNum][0]
	#ID
	var ID = ""
	
	for I in range(1,5):
		ID = ID + str(randi_range(1,9))
		
	IDChange.text = "}: " + ID
	#Nationality
	var Alphabetized = Nationalities[randi_range(1,21)]
	var Nationality = Alphabetized.pick_random()
	NationalityChange.text = "}: " + Nationality
	#Age
	AgeChange.text = "}: " + str(2060 - year)
	#Height
	var feet = randi_range(5,6)
	var inches = 0
	if feet == 5:
		inches = randi_range(3,11)
	else:
		inches = randi_range(0,4)
	var Height = str(feet) + " ft " + str(inches) + " in "
	HeightChange.text = "}: " + Height
	#Weight
	WeightChange.text = "}: " + str(randi_range(160, 215))
	#Faces
	FacesChange.text = "}: " + str(randi_range(12, 1630)) + " Days"
	#Resistance
	var POR = randi_range(1, 100)
	if POR >= 70:
		POR = "No"
	elif POR < 70:
		POR = "Yes"
	PORChange.text = "}: " + POR

#>>>>>>> 523d901d5df7e195e31dfd8b088a078c02fb941d

func _on_line_edit_text_submitted(new_text: String) -> void:
	text_edit.text = text_edit.text + "\n" + "> Processing..."
	if new_text == "#6512595-A":
		text_edit.text = text_edit.text + "\n" + "> Success"
		text_edit.text = text_edit.text + "\n" + "> Downloading..."
		MakeFile(len(GameManager.Files) + 1, "Classified", 1, 0)
	elif new_text == "Facility":
		text_edit.text = text_edit.text + "\n" + "> Success"
		text_edit.text = text_edit.text + "\n" + "> Facilities:"
		text_edit.text = text_edit.text + "\n" + "   - ADX Florence - Work camp"
		text_edit.text = text_edit.text + "\n" + "   - Manzanar - Liquidation Center"
		text_edit.text = text_edit.text + "\n" + "   - Sing Sing - Rehabilitation center"
		text_edit.text = text_edit.text + "\n" + "   - Camp X-Ray - Forced collaboration center"
	elif new_text == "Crimes":
		text_edit.text = text_edit.text + "\n" + "> Success"
		text_edit.text = text_edit.text + "\n" + "> Crimes:"
		text_edit.text = text_edit.text + "\n" + "   - Work Camp:" + "\n" + "      - Unauthorized assembly" + "\n" + "      - Undermining state moral" + "\n" + "      - Theft" + "\n" + "      - Bribery/Corruption" + "\n" + "      - Prohibited use of resources"
		text_edit.text = text_edit.text + "\n" + "   - Liquidation:" + "\n" + "      - Sabotage" + "\n" + "      - Murder" + "\n" + "      - Disobedience to orders" + "\n" + "      - Dereliction of duty" + "\n" + "      - Desertion"
		text_edit.text = text_edit.text + "\n" + "   - Rehabilitation:" + "\n" + "      - Subversive speech" + "\n" + "      - Anti-Watcher sentiment" + "\n" + "      - Counterfeiting ration tickets" + "\n" + "      - Indecent behavior" + "\n" + "      - Disrupting public order"
		text_edit.text = text_edit.text + "\n" + "   - Forced collaboration:"  + "\n" + "      - Aiding foreign agents"  + "\n" + "      - ounterfeiting papers"  + "\n" + "      - Lack of discipline"
	elif new_text == "Help":
		text_edit.text = text_edit.text + "\n" + "> Success"
		text_edit.text = text_edit.text + "\n" + "> Commands:"
		text_edit.text = text_edit.text + "\n" + "   - Facility"
		text_edit.text = text_edit.text + "\n" + "   - Crimes"
	elif new_text == "Spoffy":
		text_edit.text = text_edit.text + "\n" + "> :)"
	elif new_text == "????":
		text_edit.text = text_edit.text + "\n" + "> Playing Audio..."
		$"AudioFile#1".play()
	else:
		text_edit.text = text_edit.text + "\n" + "> ERROR"
		text_edit.text = text_edit.text + "\n" + "> If you need a list of comnmands type 'Help'"
	line_edit.clear()

var Fullscreen = false

func _on_button_pressed(BtnFunc: int) -> void:
	if BtnFunc == 1:
		visible = false
	elif BtnFunc == 2:
		pass
	elif BtnFunc == 3:
		emit_signal("close_requested")
	elif BtnFunc == 4:
		print(Accusations[AccusationsNum][1])
		var Adult = false
		if int(AgeChange.text) >= 18:
			Adult = true
		else:
			Adult = false
		if FacilityDropdown.selected == Accusations[AccusationsNum][1] - 1:
			if IDEdit.text == IDChange.text:
				if AdultCheck.button_pressed == Adult:
					if int(PrisonTermEdit.text) <= int(FacesChange.text) / 2 and PORChange.text == "Yes":
						GameManager.DayPoints = GameManager.DayPoints + GameManager.PointGains[2][1]
						print(GameManager.DayPoints)
					ChangePrisonerInfo()
					FacilityDropdown.select(-1)
					PrisonTermEdit.text = "}: "
					IDEdit.text = "}: "
					AdultCheck.toggle_mode = false
					JuvieCheck.toggle_mode = false
					AdultCheck.toggle_mode = true
					JuvieCheck.toggle_mode = true

# Dragging window
func _on_h_box_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.pressed
		drag_offset = get_global_mouse_position() - position
	elif event is InputEventMouseMotion and dragging:
		position = get_global_mouse_position() - drag_offset
		

func _on_close_button_pressed(BtnFunc):
	emit_signal("close_requested")
	if BtnFunc == 4:
		print("info submitted")
		ChangePrisonerInfo()

func _on_btn_min_pressed() -> void:
	visible = false

func _on_btn_close_pressed() -> void:
	emit_signal("close_requested")

func _on_btn_min_pris_pressed() -> void:
	visible = false

func _on_btn_close_pris_pressed() -> void:
	emit_signal("close_requested")

func _on_btn_min_email_pressed() -> void:
	visible = false

func _on_btn_close_email_pressed() -> void:
	emit_signal("close_requested")

# Email dragging
func _on_h_box_container_3_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.pressed
		drag_offset = get_global_mouse_position() - position
	elif event is InputEventMouseMotion and dragging:
		position = get_global_mouse_position() - drag_offset

var FileToggleOn = false

func _file_toggled(Name):
	FileToggleOn =! FileToggleOn
	FilepathFile = Name
	if FileToggleOn and SendButton:
		SendButton.modulate = Color(1,1,1)
		SendButton.disabled = false
	elif SendButton:
		SendButton.modulate = Color(0.65, 0.65, 0.65)
		SendButton.disabled = true

var FilepathFile = ""

var PointFiles = {
	1: "https://Classified"
}

func _on_send_button_pressed() -> void:
	PopUpMenu.visible = true
	Filepath.text = "https://" + FilepathFile

func _on_submit_pressed() -> void:
	PopUpMenu.visible = false
	SendButton.disabled = true
	SendButton.modulate = Color(0.65, 0.65, 0.65)
	if Receiver.selected == 1:
		if Filepath.text == PointFiles[1] and GameManager.PointGains[1][0] == PointFiles[1]:
			GameManager.DayPoints = GameManager.DayPoints + GameManager.PointGains[1][1]
			GameManager.PointGains.erase(1)
			print(GameManager.DayPoints)
