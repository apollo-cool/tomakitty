extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var time := Time.get_time_dict_from_system()
	
	var meridiem: String
	var hour: String
	var minute := str(time.minute)
	
	if (time.hour >= 12):
		hour = str(time.hour - 12)
		meridiem = "PM"
	else:
		meridiem = "AM"
		hour = str(time.hour)
	
	if (time.hour == 12):
		hour = "12"
	
	if (minute.length() < 2):
		minute = "0" + minute
	
	text = hour + ":" + minute + " " + meridiem
	
