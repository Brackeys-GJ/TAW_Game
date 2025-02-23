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

func MakeEmail(EmailID: int, PossibleEmails: Dictionary):
	var Instance = EMAILTEMPLATE.instantiate()
	var EmailName = Instance.get_child(0).get_child(0).get_child(1)
	var EmailDate = Instance.get_child(0).get_child(0).get_child(3)
	var EmailFrom = Instance.get_child(0).get_child(0).get_child(5)
	var Items: MenuButton = Instance.get_child(0)
	
	EmailName.text = Emails[EmailID][0]
	EmailDate.text = ClockTimer.CurrentDate
	EmailFrom.text = Emails[EmailID][1]
	
	Items.get_popup().add_item(Emails[EmailID][0], 0)
	Items.get_popup().add_item("    " + Emails[EmailID][2], 1)
	if len(Emails[EmailID]) == 5:
		Items.get_popup().add_item("    " + Emails[EmailID][3], 2)
		Items.get_popup().add_item("    " + Emails[EmailID][4], 3)
	elif len(Emails[EmailID]) == 4:
		Items.get_popup().add_item("    " + Emails[EmailID][3], 2)
		
	Emails[EmailID] = PossibleEmails[EmailID]
	
	EmailBox.add_child(Instance)

#func _ready():
	#var eye = $EyeStateMachine
	#eye.state_changed.connect(_on_eye_state_changed)
	#eye.blink_requested.connect(_on_eye_blink)
	#eye.health_changed.connect(_update_health_ui)
#
#func _on_eye_state_changed(new_state):
	#match new_state:
		#EyeStateMachine.States.MAD:
			#show_warning("Don't move!")
		#EyeStateMachine.States.IDLE:
			#hide_warning()
#
#func _update_health_ui(new_health):
	#$HealthDisplay.value = new_health
