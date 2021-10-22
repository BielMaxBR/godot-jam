extends Node2D

var ilhaCena = preload("res://scenes/ilha.tscn")

func _ready():
	for ilha in $ilhas.get_children():
		ilha.connect("value_changed", self, "_on_value_changed")
		create_line(ilha)

func _process(delta):
	var length = $ilhas.get_child_count()
	for i in length:
		var ilha = $ilhas.get_child(i)
		ilha.position = polar2cartesian(150+ilha.dist, i*(2*PI/length)-PI/2)
		var linha = $linhas.get_child(i)
		linha.set_point_position(1, ilha.position)


func _on_value_changed(ilha, new_value):
	var length = $ilhas.get_child_count()
	var diff = new_value - ilha.dist
	var sub = diff/(length-1)
	
	for outraIlha in $ilhas.get_children():
		if outraIlha != ilha:
			outraIlha.dist -= sub

func create_line(ilha):
	var line = Line2D.new()
	
	line.add_point(Vector2.ZERO)
	line.add_point(Vector2.ONE*15)
	
	line.width = 10
	$linhas.add_child(line)

func add_ilha():
	var newIlha = ilhaCena.instance()
	newIlha.connect("value_changed", self, "_on_value_changed")
	create_line(newIlha)
	$ilhas.add_child(newIlha)
