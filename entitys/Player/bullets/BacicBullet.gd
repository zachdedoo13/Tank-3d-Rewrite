extends CharacterBody3D

# placeholder
var bounce = null
var speed = null
var dir = null

func set_veriables(pos, direc, boing, spd):
	position = pos
	speed = spd
	dir = Vector2.from_angle(direc - deg_to_rad(180))
	dir *= speed
	bounce = boing

func _physics_process(delta):
	dir *= delta
	var test = Vector2(0, 0)
	velocity.z = dir.x
	velocity.x = dir.y
	
	var collision = move_and_collide(velocity)
	
	if collision:
		if bounce:
			if collision.get_collider().is_in_group("walls"):
				velocity = velocity.bounce(collision.get_normal())
				print(velocity)
				test.x = velocity.z
				test.y = velocity.x
				rotation.y = test.angle()
		else:
			print(collision.get_collider())
			get_parent().queue_free()
