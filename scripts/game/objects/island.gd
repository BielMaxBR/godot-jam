extends Node2D

export(float) var distance = 0
export(float) var level = 0


signal value_changed(ilha, value)

func _ready():
	$AnimationPlayer.play("connector")

func _process(delta):
	var new_distance = distance + (level*Globals.step_size)

	emit_signal("value_changed", self, new_distance)
	distance = new_distance

func _on_TextureButton_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed == true:
			if event.button_index == 1: # esquerdo
				level = clamp(level+1,-2,2)
#				if vel > 0: vel *= 1.2
#				elif vel < 0: vel = 0
#				else: vel = 0.01
#				print(vel)
			if event.button_index == 2: # direito
				level = clamp(level-1,-2,2)
#				if vel < 0: vel *= 1.2
#				elif vel > 0: vel = -0
#				else: vel = -0.01
			pass
