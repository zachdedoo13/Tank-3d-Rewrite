extends Node3D

var debug = []

func _ready():
	SignalManager.MousePos.connect(get_mouse_pos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_mouse_pos(pos):
	pos.y = position.y
	look_at(pos)
	
	var ret = RayTool.check_direction(position, rotation.y, true)
	
	debug.append(ret[3])
	if len(debug) > 3:
		debug[0].queue_free()
		debug.remove_at(0)


