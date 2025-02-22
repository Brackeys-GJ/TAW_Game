extends Node

var Hour = 1
var Min = 0

var month = 4
var day = 5
var year = 2060

var ClockLevel = ""
var CurrentDate = str(month) + "/" + str(day) + "/" + str(year)

func StartClock():
	if Min < 10:
		ClockLevel = str(Hour) + ":0" + str(Min)
	else:
		ClockLevel = str(Hour) + ":" + str(Min)
	ClockTimer.start()

func _on_timer_timeout() -> void:
	if Min == 59:
		Hour = Hour + 1
		Min = 0
	else:
		Min = Min + 1
	if Hour == 24:
		day = day + 1
		CurrentDate = str(month) + "/" + str(day) + "/" + str(year)
		Min = 0
		Hour = 1
	StartClock()
