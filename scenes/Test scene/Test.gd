extends Node3D

var mouse_pos = 0 
var points = []
var lines = []

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.MousePos.connect(get_mouse_pos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("left_click"):
		points.append(Draw3d.point(mouse_pos))
		if len(points) > 1:
			lines.append(Draw3d.line(points[-1].global_position, points[-2].global_position))
		
	if Input.is_action_just_pressed("right_click"):
		for i in range(len(points)):
			points[i].queue_free()
		points.clear()
		for i in range(len(lines)):
			lines[i].queue_free()
		lines.clear()

func get_mouse_pos(pos):
	mouse_pos = pos
