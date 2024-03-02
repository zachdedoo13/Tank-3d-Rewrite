extends CharacterBody3D

@export var SPEED : float
@export var TURN_SPEED : float
@export var HEALTH : int

var dir = Vector2(0, 0)

func _ready() -> void:
	SignalManager.BulletHit.connect(check_hit)

func check_hit(object) -> void:
	if object == self:
		print("hit player")
		HEALTH -= 1
		print(HEALTH)
		if HEALTH <= 0:
			get_parent().get_parent().queue_free()

func movement(delta) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var move = direction * SPEED * delta
	position += Vector3(move.x, 0, move.y)
	move_and_slide()
	
	rotate_body(delta, direction, 10)

func rotate_body(delta, direction:Vector2, rotate_speed) -> void:
	var change_rotate = Vector2(-direction.y, -direction.x).angle()
	rotation.y = change_rotate

func _physics_process(delta) -> void:
	
	if Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2(0, 0):
		movement(delta)

