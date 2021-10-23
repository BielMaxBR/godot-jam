extends Node2D

var island_scene: PackedScene = preload("res://scenes/game/objects/Island.tscn")

# Just fun \/
var angle = 0
var dist = 0
var inv = false
# Just fun /\

func _physics_process(delta):
	#if Input.is_action_just_pressed("space"):
		update_islands()
		
		# Just fun \/
		if inv:
			dist -= 0.1
		else:
			dist += 0.1
		
		if dist >= 50:
			inv = true
		elif dist <= 0:
			inv = false
		# Just fun /\

# Atualiza as ilhas
func update_islands() -> void:
	var length: int = $Islands.get_child_count()
	for i in length:
		var island: Node2D = $Islands.get_child(i)
		var island_connector: Line2D = island.get_node("Connector")
		island.position = polar2cartesian(dist+150+island.distance, (i*(2*PI/length)-PI/2) + deg2rad(angle)) # polar2cartesian(150 + island.distance, i*(2*PI/length)-PI/2)
		island_connector.set_point_position(1, island_connector.to_local(global_position))
	# Just fun \/
	angle += 0.5
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