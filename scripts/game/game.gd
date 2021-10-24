extends Node2D

var added_island = false
var next_minute = 1

func _ready():
	Globals.reset()

func _process(delta):

	$"Menu_e_Fundo-1".position.x += 2
	if $"Menu_e_Fundo-1".position.x == 1024:
		$"Menu_e_Fundo-1".position.x = 0
	
	if Globals.minutes == next_minute:
		added_island = false
		next_minute += 1
	
	if Globals.seconds == 30 and not added_island:
		$Core.add_island(randi() % 5)
		added_island = true
	
	
	
