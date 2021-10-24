extends TextureButton

export(String) var scene
export(Texture) var texture

func _ready():
	if texture:
		texture_normal = load(texture)

func _on_Button_pressed():
	get_tree().change_scene(scene)
