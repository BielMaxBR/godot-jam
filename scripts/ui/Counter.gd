extends Label

func _ready():
	$Timer.start()


func _on_Timer_timeout():
	if Globals.death: 
		$Timer.autostart = false
		return
	Globals.seconds += 1
	if Globals.seconds == 60:
		Globals.seconds = 0
		Globals.minutes += 1
	
	text = str(Globals.minutes)+":"+str(Globals.seconds)
