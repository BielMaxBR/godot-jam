extends Control

func _process(delta):
	if Globals.death:
		show()
