extends Node2D

signal distance_changed(island, value)
signal level_changed(island, value)

export(float) var distance: float = 0 setget set_distance
export(float) var level: int = 0 setget set_level

enum ISLAND_TYPE {
	CIDADE,
	FERIAS
}

var island_type = ISLAND_TYPE.CIDADE setget set_island_type

var ISLANDS_TEXTURE = {
	ISLAND_TYPE.CIDADE: load("res://sprites/islands/Ilha_Cidade.png"),
	ISLAND_TYPE.FERIAS: load("res://sprites/islands/Ilha_de_Ferias.png")
}

func _ready():
	$Connector/ConnectorAnimation.play("connector")
	$Level/LevelAnimation.play("level")
	randomize()
	$Timer.wait_time = rand_range(Globals.min_time, Globals.max_time)

func _physics_process(delta: float) -> void:
	update_distance()


func update_level_textures() -> void:
	$Level.set_animation(str(level))
	print(level)
	
func update_distance() -> void:
	var new_distance = distance + (level * Globals.step_size)

	emit_signal("distance_changed", self, new_distance)
	self.distance = new_distance

func level_up() -> void:
	self.level = clamp(level+1,-2,2)

func level_down() -> void:
	self.level = clamp(level-1,-2,2)


func set_island_type(_island_type: int):
	island_type = _island_type
	$Texture.texture_normal = ISLANDS_TEXTURE[island_type]
	
func set_level(_level: int) -> void:
	level = _level
	update_level_textures()
	emit_signal("level_changed", self, level)

func set_distance(_distance: float) -> void:
	distance = _distance

func _on_Timer_timeout():
	randomize()
	$Timer.wait_time = rand_range(Globals.min_time, Globals.max_time)

	self.level += clamp(round(rand_range(-Globals.lvl_floating, Globals.lvl_floating)),-2,2)

func _on_TextureButton_gui_input(event) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			match event.button_index:
				BUTTON_LEFT:
					level_up()
				BUTTON_RIGHT:
					level_down()
