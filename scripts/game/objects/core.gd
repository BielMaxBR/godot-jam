extends Node2D

var island_scene: PackedScene = preload("res://scenes/game/objects/Island.tscn")

# Just fun \/
var angle = 0
# Just fun /\

func _ready():
	for i in 8:
		add_island(randi() % 4)

func _physics_process(delta):
	#if Input.is_action_just_pressed("space"):
		update_islands()

func add_island(type: int) -> void:
	var island_instance = island_scene.instance()
	island_instance.set_name(str(island_instance.get_instance_id()))
	island_instance.set_island_type(type)
	$Islands.add_child(island_instance)
	island_instance.connect("distance_changed", self, "_on_distance_changed")

# Atualiza as ilhas
func update_islands() -> void:
	var length: int = $Islands.get_child_count()
	var danger_level = 0
	for i in length:
		var island: Node2D = $Islands.get_child(i)
		var island_connector: Line2D = island.get_node("Connector")
		var new_position = polar2cartesian(150 + island.distance, i*(2*PI/length)-PI/2 + deg2rad(angle))
		island.position = new_position
		island_connector.set_point_position(1, island_connector.to_local(global_position))
		if island.distance <= -30:# and island.distance <= -50:
			danger_level = 1
		if island.distance <= -50:
			danger_level = 2
	
	match danger_level:
		0:
			$Texture.play("safe")
		1:
			$Texture.play("warning")
		2:
			$Texture.play("danger")
	
	# Just fun \/
	angle += 0.15

func _on_distance_changed(island, new_distance):
	var length = $Islands.get_child_count()
	var diff = new_distance - island.distance
	var sub = (length/2)*diff/(length-1)

	for otherIsland in $Islands.get_children():
		if otherIsland != island:
			otherIsland.distance -= sub

#
## Atualiza os conectores
#func update_connectors() -> void:
#
#
#func _ready():
#	for island in $islands.get_children():
#		island.connect("value_changed", self, "_on_value_changed")
#		create_connector(island)
#
#	for island in $Islands.get_children():
#		island.connect("value_changed", self, "_on_value_changed")

#func _process(delta):
#	var length = $ilhas.get_child_count()
#	for i in length:
#		var ilha = $ilhas.get_child(i)
#		ilha.position = polar2cartesian(150+ilha.distance, i*(2*PI/length)-PI/2)
#		var linha = $linhas.get_child(i)
#		linha.set_point_position(1, ilha.position)
#
#
#func _on_value_changed(ilha, new_value):
#	var length = $ilhas.get_child_count()
#	var diff = new_value - ilha.distance
#	var sub = diff/(length-1)
#
#	for outraIlha in $ilhas.get_children():
#		if outraIlha != ilha:
#			outraIlha.distance -= sub
#
#func create_line(ilha):
#	var line = Line2D.new()
#
#	line.add_point(Vector2.ZERO)
#	line.add_point(Vector2.ONE*15)
#
#	line.width = 10
#	$linhas.add_child(line)
#
#func add_ilha():
#	var newIlha = ilhaCena.instance()
#	newIlha.connect("value_changed", self, "_on_value_changed")
#	create_line(newIlha)
#	$ilhas.add_child(newIlha)
