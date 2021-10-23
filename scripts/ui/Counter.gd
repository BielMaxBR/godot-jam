extends Label

var seconds = 0
var minutes = 0
func _ready():
	$Timer.start()


func _on_Timer_timeout():
	seconds += 1
	if seconds == 60:
		seconds = 0
		minutes += 1
	
	text = str(minutes)+":"+str(seconds)
