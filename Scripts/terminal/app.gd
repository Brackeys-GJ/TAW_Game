extends Control

@onready var text_edit: TextEdit
@onready var line_edit: LineEdit

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

func _ready() -> void:
	if App == 1:
		pass
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
		ChangePrisonerInfo()

func ChangePrisonerInfo():
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
	AccusationChange.text = Accusations.pick_random()
	#ID
	var Num = 0
	var ID = ""
	
	for I in range(1,5):
		Num = str(randi_range(1,9))
		ID = ID + Num
		
	IDChange.text = ID
	#Nationality
	var Alphabetized = Nationalities[randi_range(1,21)]
	var Nationality = Alphabetized.pick_random()
	NationalityChange.text = Nationality
	#Age
	AgeChange.text = str(2060 - year)

func _on_line_edit_text_submitted(new_text: String) -> void:
	text_edit.text = text_edit.text + "\n" + "> Processing..."
	if new_text == "1244":
		text_edit.text = text_edit.text + "\n" + "> Success"
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
		pass
	elif BtnFunc == 4:
		print("info submitted")
		ChangePrisonerInfo()
