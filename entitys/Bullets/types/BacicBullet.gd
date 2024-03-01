extends CharacterBody3D
class_name Bullet

var speed = null
var bounce = null

var collisions = 0

func start(pos, dir, spd, bou):
	rotation.y = dir - deg_to_rad(180)
	position = pos
	speed = spd
	bounce = bou

func _ready():
	print(rotation.y)
	var vel = Vector2.from_angle(rotation.y) * speed
	velocity = Tools.vec2ToVec3(vel, 0)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		collisions += 1
		if collisions > 1:
			queue_free()
		velocity = velocity.bounce(collision.get_normal())
