extends CharacterBody3D

@export var SPEED : float
@export var TURN_SPEED : float
@export var HEALTH : int

var dir = Vector2(0, 0)

func movement(delta) -> Vector2:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var move = direction * SPEED * delta
	position += Vector3(move.x, 0, move.y)
	move_and_slide()
	
	return direction

func rotate_body(delta, direction:Vector2, rotate_speed) -> void:
	var change_rotate = Vector2(-direction.y, -direction.x).angle()
	print(rad_to_deg(change_rotate))
	rotation.y = lerp(rotation.y, change_rotate, rotate_speed * delta)

func _physics_process(delta) -> void:

	dir = movement(delta)
	
	rotate_body(delta, dir, 10)
