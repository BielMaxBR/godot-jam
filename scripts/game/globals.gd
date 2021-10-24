extends Node

var step_size = 0.3

var min_time = 10
var max_time = 20

var lvl_floating = 1

var seconds = 0
var minutes = 0

var death = false

var SAFE_DISTANCE = 35
var DANGER_DISTANCE = 60
var DEATH_DISTANCE = 100

func reset():
	step_size = 0.3

	min_time = 10
	max_time = 20

	lvl_floating = 1

	seconds = 0
	minutes = 0

	death = false
