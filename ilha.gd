extends Node2D

export(float) var dist = 0
export(float) var vel = 0
export(float) var acc = 0

signal value_changed(ilha, value)

func _process(delta):
	vel += acc
	var new_dist = dist + vel

	emit_signal("value_changed", self, new_dist)
	dist = new_dist

#	emit_signal("value_changed", self, new_value)
#	dist = new_dist


func _on_TextureButton_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed == true:
			if event.button_index == 1: # esquerdo
				if vel > 0: vel *= 1.2
				elif vel < 0: vel = 0
				else: vel = 0.01
				print(vel)
			if event.button_index == 2: # direito
				if vel < 0: vel *= 1.2
				elif vel > 0: vel = -0
				else: vel = -0.01
