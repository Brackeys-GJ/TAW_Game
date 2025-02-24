extends Node

const EMAILTEMPLATE = preload("res://Scences/terminal/emailapp/email_template.tscn")

var PointGains = {
	1: ["https://Classified", 25],
	2: ["SavingPrisoners", 10],
}

var DayPoints = 0

var CompletedDays = 0
var SuccusfulDays = 0
var FailedDays = 0

var Emails = {}

var Files = {}

var FilesNeedAdded = []

var EmailBox = null

func _ready():
	HealthManager.health_changed.connect(_update_health_ui)
	HealthManager.game_over.connect(_on_game_over)

func _update_health_ui(new_health):
	# UI elements
	pass

func _on_game_over():
	FailedDays += 1
	#show_game_over_screen()
	#reset_day()
#
#func reset_day():
	#HealthManager.reset_health()

func MakeEmail(EmailID: int, PossibleEmails: Dictionary):
	if not EmailID in Emails:
		var Instance = EMAILTEMPLATE.instantiate()
		var EmailName = Instance.get_child(0).get_child(0).get_child(1)
		var EmailDate = Instance.get_child(0).get_child(0).get_child(3)
		var EmailFrom = Instance.get_child(0).get_child(0).get_child(5)
		var Items: MenuButton = Instance.get_child(0)
		
		EmailName.text = PossibleEmails[EmailID][0]
		EmailDate.text = ClockTimer.CurrentDate
		EmailFrom.text = PossibleEmails[EmailID][1]
		
		Items.get_popup().add_item(PossibleEmails[EmailID][0], 0)
		Items.get_popup().add_item("    " + PossibleEmails[EmailID][2], 1)
		if len(PossibleEmails[EmailID]) == 5:
			Items.get_popup().add_item("    " + PossibleEmails[EmailID][3], 2)
			Items.get_popup().add_item("    " + PossibleEmails[EmailID][4], 3)
		elif len(PossibleEmails[EmailID]) == 4:
			Items.get_popup().add_item("    " + PossibleEmails[EmailID][3], 2)
		
		Emails[len(Emails) + 1] = PossibleEmails[EmailID]
		
		EmailBox.add_child(Instance)
