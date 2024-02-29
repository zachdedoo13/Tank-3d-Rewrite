extends CharacterBody3D

func do_the_moveing(dir, bounce):
	var test = Vector2(0, 0)
	velocity.z = dir.x
	velocity.x = dir.y
	
	var collision = move_and_collide(velocity)
	
	if collision:
		if bounce:
			if collision.get_collider().is_in_group("walls"):
				move_and_collide(velocity.bounce(collision.get_normal()))
				velocity = velocity.bounce(collision.get_normal())
				print(velocity)
				test.x = velocity.z
				test.y = velocity.x
				rotation.y = test.angle()
		else:
			print(collision.get_collider())
			get_parent().queue_free()
