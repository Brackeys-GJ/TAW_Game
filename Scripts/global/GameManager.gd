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
	3: ["Mistake email", "Watchers", "#6512595-A"],
	#Above Goal Emails
	4: ["Day 1", "Cipher",
	"The intel you sent saved a lot of lives. Thank you. We are still far from our goal, but just everyday we get closer to freedom"],
	5: ["Day 2", "Cipher",
	"We are starting to coordinate our moves against the watchers. You have freed many of us and caused some major blows to the",
	"Watchers logistics. Remember to stay low, they are bound to get on to the fact that they have a rat on the inside."],
	6: ["Day 3", "Cipher",
	"I used to not think about it, but I am starting to remember life before the Watchers. Our offensive is starting to",
	"take shape, and I can’t help thinking about the world as it was. This is all thanks to you",
	"and your efforts. You are bound to be in the history books my friend"],
	7: ["Day 4", "Cipher",
	"The offensive is all planned out, we just need to rest of the resources and personnel to make it happen.",
	"It is up to you today. Your place is our first stop. We are gonna break",
	"you out along with of those the Watchers have enslaved"],
	8: ["Day 5", "Cipher",
	"You might as well pack up the desk, you won’t be doing much work today. Just make sure once you hear a few",
	"bangs just duck down for us and we will take care of the rest. You will be debriefed once we secure the",
	"building. You did some great work back there; you deserve some rest once this is all over"],
	#Below Goal Emails
	9: ["Day 1", "Cipher",
	"Yesterday didn’t go as planned. We still have 4 days but everyday counts. Lets make today a good one"],
	10: ["Day 2", "Cipher",
	"There is a growing fear that the Watchers may be zeroing in on us. We are not nearly as strong as we",
	"would like to be. Humanity needs you to really pull through these next few days. Don’t let us down"],
	11: ["Day 3", "Cipher",
	"Things are not looking good here. Our raids on Watcher positions have ended in disaster, it is like they are predicting our every",
	"move. Look, I now risking your life doesn’t sound like the greatest thing to do, but when humanity is on the brink of permanent",
	"enslavement. All I am saying is lets think a bit more about the big picture here"],
	12: ["Day 4", "Anders Coleman",
	"This is General Anders Coleman of the North American Resistance. Cipher is dead. The Watchers know where we are. It is only a",
	"matter of time before they strike. It would take a miracle to save us. Today I need you to be a soldier. Many of my men have",
	"died over the past week, maker sure it isn’t for nothing"],
	13: ["Day 5", "Anders Coleman",
	"They have breached the west wall. They are even in the tunnels. The courtyard is has been overrun and all exits are cut off.",
	"We cannot get out.",
	"They were always Watching…"],
	}

var CurrentEmails: = []

var Files = {}

var FilesNeedAdded = []

var EmailsNeedAdded = []

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

func MakeEmail(EmailID: int):
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
	
	if not EmailID in CurrentEmails:
		CurrentEmails.append(EmailID)
	
	if EmailBox:
		EmailBox.add_child(Instance)
