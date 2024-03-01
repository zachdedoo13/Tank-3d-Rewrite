extends CharacterBody3D
class_name Bullet

var speed = null
var bounce = null

var mouse_pos = 0

var collisions = 0

func get_mouse_pos(pos):
	mouse_pos = pos

func start(pos, dir, spd, bou):
	rotation.y = dir
	position = pos
	speed = spd
	bounce = bou

func _ready():
	print(rotation.y)
	SignalManager.MousePos.connect(get_mouse_pos)
	var vel = Vector2.from_angle(rotation.y) * speed
	velocity = Tools.vec2ToVec3(vel, 0)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		SignalManager.BulletHit.emit(collision.get_collider())
		print("bullet collided")
		collisions += 1
		if collisions > 1:
			queue_free()
		velocity = velocity.bounce(collision.get_normal())
