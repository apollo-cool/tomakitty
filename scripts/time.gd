extends Label

@onready var minute_timer: Timer = %MinuteTimer

var first_run := true

func _ready() -> void:
	_on_minute_passed()
	# First we have to synchronize our time for accuracy
	var time := Time.get_time_dict_from_system()
	var second: int = time.second
	var time_left := 60 - second
	minute_timer.wait_time = time_left
	minute_timer.start()

func _on_minute_passed() -> void:
	if (first_run):
		minute_timer.wait_time = 60
		minute_timer.one_shot = false
	
	var time := Time.get_time_dict_from_system()
	
	var meridiem: String
	var hour: String
	var minute := str(time.minute)
	
	if (time.hour >= 12):
		hour = str(time.hour - 12)
		meridiem = "PM"
	elif (time.hour == 24):
		meridiem = "AM"
		hour = "12"
	else:
		meridiem = "AM"
		hour = str(time.hour)
	
	if (time.hour == 12):
		hour = "12"
	
	if (minute.length() < 2):
		minute = "0" + minute
	
	text = hour + ":" + minute + " " + meridiem
