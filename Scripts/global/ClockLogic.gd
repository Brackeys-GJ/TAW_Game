extends Node

var DailyRequiredPoints = 15

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

var Hour = 9
var Min = 0

var month = 4
var day = 5
var year = 2060

var ClockLevel = ""
var CurrentDate = str(month) + "/" + str(day) + "/" + str(year)

var CodeEmailSent = false

func StartClock():
	if Min < 10:
		ClockLevel = str(Hour) + ":0" + str(Min)
	else:
		ClockLevel = str(Hour) + ":" + str(Min)
	ClockTimer.start()

func _on_timer_timeout() -> void:
	if Min == 50:
		Hour = Hour + 1
		Min = 0
	else:
		Min = Min + 5
		if randi_range(1, 100) > 95 and not CodeEmailSent:
			CodeEmailSent = true
			GameManager.EmailsNeedAdded.append(3)
	if Hour == 24:
		day = day + 1
		GameManager.CompletedDays = GameManager.CompletedDays + 1
		if GameManager.DayPoints >= DailyRequiredPoints:
			GameManager.SuccusfulDays = GameManager.SuccusfulDays + 1
			if GameManager.SuccusfulDays == 1:
				GameManager.EmailsNeedAdded.append(4)
			elif GameManager.SuccusfulDays == 2:
				GameManager.EmailsNeedAdded.append(5)
			elif GameManager.SuccusfulDays == 3:
				GameManager.EmailsNeedAdded.append(6)
			elif GameManager.SuccusfulDays == 4:
				GameManager.EmailsNeedAdded.append(7)
			elif GameManager.SuccusfulDays == 5:
				GameManager.EmailsNeedAdded.append(8)
		elif GameManager.DayPoints < DailyRequiredPoints:
			GameManager.FailedDays = GameManager.FailedDays + 1
			if GameManager.FailedDays == 1:
				GameManager.EmailsNeedAdded.append(9)
			elif GameManager.FailedDays == 2:
				GameManager.EmailsNeedAdded.append(10)
			elif GameManager.FailedDays == 3:
				GameManager.EmailsNeedAdded.append(11)
			elif GameManager.FailedDays == 4:
				GameManager.EmailsNeedAdded.append(12)
			elif GameManager.FailedDays == 5:
				GameManager.EmailsNeedAdded.append(13)
		CurrentDate = str(month) + "/" + str(day) + "/" + str(year)
		Min = 0
		Hour = 1
	if GameManager.CompletedDays == 5:
		if GameManager.SuccusfulDays >= 3:
			get_tree().change_scene_to_file("res://Scences/cinematics/win.tscn")
			ClockTimer.stop()
		else:
			get_tree().change_scene_to_file("res://Scences/cinematics/GameOver.tscn")
			ClockTimer.stop()
	else:
		StartClock()
