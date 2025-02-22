extends Control
#Preloading Templates
const FILESTEMPLATE = preload("res://Scences/terminal/filesapp/filestemplate.tscn")
const FOLDERTEMPLATE = preload("res://Scences/terminal/filesapp/foldertemplate.tscn")
const EMAILTEMPLATE = preload("res://Scences/terminal/emailapp/email_template.tscn")

@onready var FileBox: VBoxContainer
@onready var FolderBox: VBoxContainer

@export var app_icon: Texture2D

var FileTypes = {
	1: "Text",
	2: "Image",
	3: "Application",
	}

var StartingFiles = {
	#FORMAT: Key: ["Name", "Date", Filetype, Folder(If none set: 0)],
	1: ["📁  Files","01/03/2059",3, 1],
	2: ["📄  Work Notes","11/18/2062",1, 3],
	3: ["📄  Passwords","03/18/2059",1, 3],
	4: ["💿  Command Prompt","01/03/2059",1, 1],
	}

var StartingFilesAmount = len(StartingFiles)

var StartingFolders = {
	#FORMAT: Key: "Name",
	1: "Desktop",
	2: "Downloads",
	3: "Documents",
	4: "Gallery"
	}

var Folders = {
	
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
var Accusations = [
	"Subversive speech",
	"Unauthorized assembly",
	"Aiding foreign agents",
	"Anti-Watcher sentiment",
	"Undermining state moral",
	"Sabotage",
	"Theft",
	"Bribery/Corruption",
	"Counterfeiting ration tickets",
	"Counterfeiting papers",
	"Indecent behavior",
	"Disrupting public order",
	"Murder",
	"Disobedience to orders",
	"Dereliction of duty",
	"Lack of discipline",
	"Prohibited use of resources",
	"Desertion",
	]
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
		for I in range(1,5):
			MakeFolder(StartingFolders[I])
		for I in range(1,StartingFilesAmount + 1):
			MakeFile(StartingFiles[I][0], StartingFiles[I][1], StartingFiles[I][2], StartingFiles[I][3])
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
		for I in range(1,len(GameManager.Emails) + 1):
			GameManager.Emails[I] = PossibleEmails[I]
			MakeEmail(I)

func MakeFile(FileName: String, FileDate: String, Filetype: int, Folder: int):
		#Getting File Instance
		var Instance = FILESTEMPLATE.instantiate()
		#Getting File Info As Vars
		var FileNameLabel = Instance.get_child(0).get_child(0).get_child(0)
		var FileDateLabel = Instance.get_child(0).get_child(0).get_child(1)
		var FiletypeLabel = Instance.get_child(0).get_child(0).get_child(2)
		#Setting File Info
		FileNameLabel.text = FileName
		FileDateLabel.text = FileDate
		FiletypeLabel.text = FileTypes[Filetype]
		Instance.name = FileName
		#Adding As child of FileBox
		FileBox.add_child(Instance)
		if Folder:
			Folders[StartingFolders[Folder]].append(str(Instance.name))
		else:
			print("No folder")
		print(Folders)

func MakeFolder(FolderName: String):
	var FolderAmount = len(Folders)
	#Getting Folder Instance
	var Instance = FOLDERTEMPLATE.instantiate()
	#Getting Folder Info As Vars
	var FolderNameText = Instance.get_child(0)
	#Setting Folder Info
	FolderNameText.text = "📁  " + FolderName
	Instance.name = FolderName
	#Adding As child of FolderBox
	FolderBox.add_child(Instance)
	#Adding Folder to Folder Arrey
	Folders[Instance.name] = []
	print(Folders)

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
	AccusationChange.text = "}: " + Accusations.pick_random()
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

func MakeEmail(EmailID: int):
	print(GameManager.Emails)
	var Instance = EMAILTEMPLATE.instantiate()
	
	var EmailName = Instance.get_child(0).get_child(0).get_child(1)
	var EmailDate = Instance.get_child(0).get_child(0).get_child(3)
	var EmailFrom = Instance.get_child(0).get_child(0).get_child(5)
	var Items: MenuButton = Instance.get_child(0)
	
	var EmailItems = GameManager.Emails
	
	EmailName.text = EmailItems[EmailID][0]
	EmailDate.text = ClockTimer.CurrentDate
	EmailFrom.text = EmailItems[EmailID][1]
	
	Items.get_popup().add_item(EmailItems[EmailID][0], 0)
	Items.get_popup().add_item("    " + EmailItems[EmailID][2], 1)
	if len(EmailItems[EmailID]) == 5:
		Items.get_popup().add_item("    " + EmailItems[EmailID][3], 2)
		Items.get_popup().add_item("    " + EmailItems[EmailID][4], 3)
	elif len(EmailItems[EmailID]) == 4:
		Items.get_popup().add_item("    " + EmailItems[EmailID][3], 2)
		
	GameManager.Emails[EmailID] = PossibleEmails[EmailID]
	
	Emails.add_child(Instance)
#>>>>>>> 523d901d5df7e195e31dfd8b088a078c02fb941d

func _on_line_edit_text_submitted(new_text: String) -> void:
	text_edit.text = text_edit.text + "\n" + "> Processing..."
	if new_text == "#6512595-A":
		text_edit.text = text_edit.text + "\n" + "> Success"
		text_edit.text = text_edit.text + "\n" + "> Downloading..."
	elif new_text == "Spoffy":
		text_edit.text = text_edit.text + "\n" + "> :)"
	elif new_text == "Creeper":
		text_edit.text = text_edit.text + "\n" + "> Playing Audio..."
		$Creeper.play()
	elif new_text == "Link":
		text_edit.text = text_edit.text + "\n" + "> Playing Audio..."
		$Link.play()
	elif new_text == "Mouse Link":
		text_edit.text = text_edit.text + "\n" + "> Playing Audio..."
		$MouseLink.play()
	elif new_text == "????":
		text_edit.text = text_edit.text + "\n" + "> Playing Audio..."
		$"AudioFile#1".play()
	elif new_text == "":
		pass
	else:
		text_edit.text = text_edit.text + "\n" + "> ERROR"
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
