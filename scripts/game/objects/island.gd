extends Node2D

signal distance_changed(island, value)
signal level_changed(island, value)

export(float) var distance: float = 0 setget set_distance
export(float) var level: int = 0 setget set_level

enum ISLAND_TYPE {
	CIDADE,
	FERIAS,
	NEVE,
	CASTELO,
	COHAB,
	FABRICA
}

var island_type = ISLAND_TYPE.CIDADE setget set_island_type

var last_level

var ISLANDS_TEXTURE = {
	ISLAND_TYPE.CIDADE: load("res://sprites/islands/Ilha_Cidade.png"),
	ISLAND_TYPE.NEVE: load("res://sprites/islands/Ilha_de_Patinacao_no_Gelo.png"),
	ISLAND_TYPE.CASTELO: load("res://sprites/islands/Ilha_Castelo.png"),
	ISLAND_TYPE.COHAB: load("res://sprites/islands/Ilha_de_COHAB.png"),
	ISLAND_TYPE.FABRICA: load("res://sprites/islands/Ilha_das_Fabricas.png"),
	ISLAND_TYPE.FERIAS: load("res://sprites/islands/Ilha_de_Ferias.png")
}

var rng = RandomNumberGenerator.new()

func _ready():
	$Connector/ConnectorAnimation.play("connector")
	$Level/LevelAnimation.play("level")
	rng.randomize()
	$Timer.wait_time = rng.randi_range(Globals.min_time, Globals.max_time)
	$Timer.start()

func _physics_process(delta: float) -> void:
	update_distance()

func update_level_textures() -> void:
	$Level.set_animation(str(-level))
	if last_level != level and level != 0:
		get_node("lvl"+str(-level)).play()
	last_level = level
	
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
	level = clamp(_level,-2,2)
	update_level_textures()
	emit_signal("level_changed", self, level)

func set_distance(_distance: float) -> void:
	distance = _distance

func _on_Timer_timeout():
	if Globals.death: return
	rng.randomize()
	$Timer.wait_time = rand_range(Globals.min_time, Globals.max_time)
	$Timer.start()
	self.level += clamp(rng.randi_range(-Globals.lvl_floating, Globals.lvl_floating),-2,2)

func _on_TextureButton_gui_input(event) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			match event.button_index:
				BUTTON_LEFT:
					level_up()
				BUTTON_RIGHT:
					level_down()
