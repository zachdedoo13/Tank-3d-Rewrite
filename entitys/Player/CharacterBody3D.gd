extends CharacterBody3D

@export var speed : int

var clear = []
var mouse_pos = Vector3(0,0,0)

func _ready():
	SignalManager.MousePos.connect(get_mouse_pos)

func get_mouse_pos(pos):
	mouse_pos = Vector3(pos.x, $barrel.global_position.y, pos.z)

func move_turrent():
	#clear.append(RayTool.check_direction($barrel.global_position, $barrel.global_rotation.y, true)[3])
	#RayTool.clear_check_direction(clear)
	$barrel.look_at(mouse_pos)

func _physics_process(delta):
	if Input.is_anything_pressed():
		movement(delta)
	move_turrent()

func movement(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var move = direction * speed * delta
	position += Vector3(move.x, 0, move.y)
	move_and_slide()
	
	rotate_the_tank(direction)

func rotate_the_tank(direction):
	direction = Vector2(-direction.y, -direction.x)
	rotation.y = direction.angle()

