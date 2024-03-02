extends Node3D

var debug = []
var debug2 = []

func _ready():
	SignalManager.MousePos.connect(look_at_mouse_pos)


func _process(delta):
	var stuff = RayTool.check_direction_bounce(position, rotation.y, true)
	debug.append(stuff[3])
	debug2.append(stuff[7])
	RayTool.clear_check_direction(debug, 100)
	RayTool.clear_check_direction(debug2, 100)
	
func look_at_mouse_pos(pos):
	pos.y = position.y
	look_at(pos)
	
	


