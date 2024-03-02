extends Node

# raycast in direction
func check_direction(position:Vector3, direction:float, draw=true, collision_mask=2, debug_look_vector=null) -> Array:
	var ret = [false, null, false, null, false, false]
	
	direction += PI
	
	var look_vector = null
	var raycast := RayCast3D.new()
	if debug_look_vector != null:
		look_vector = debug_look_vector
	else:
		look_vector = Vector2(cos(direction), sin(direction))
	var target = Vector3(look_vector.y, 0, look_vector.x)
	
	raycast.enabled = true
	raycast.position = position
	raycast.target_position = target * 1_000
	raycast.target_position.y = position.y
	raycast.collide_with_areas = true
	raycast.set_collision_mask_value(1, false)
	raycast.set_collision_mask_value(collision_mask, true)
	
	get_tree().get_root().add_child(raycast)
	raycast.force_raycast_update()
	
	if raycast.is_colliding():
		ret[0] = true
		ret[1] = raycast.get_collider()
		ret[2] = raycast.get_collision_point()
		ret[4] = raycast.get_collision_normal()
		
	raycast.queue_free()
		
	if draw:
		var line = 0
		if ret[0] == true:
			line = Draw3d.line(raycast.position, ret[2])
		else:
			line = Draw3d.line(raycast.position, raycast.target_position)
		ret[3] = line
		
		ret[5] = look_vector
	return ret

func clear_check_direction(ret:Array, on_screen=1) -> Array:
	if len(ret) > on_screen:
		if ret[0] != null:
			ret[0].queue_free()
		else:
			print("saved at queue_free")
		ret.remove_at(0)
	return ret

func check_direction_bounce(position:Vector3, direction:float, draw=true, collision_mask=2) -> Array:
	var ret = [false, false, false, false, false, false, false, false]
	
	direction += PI
	
	var raycast := RayCast3D.new()
	var look_vector = Vector2(cos(direction), sin(direction))
	var target = Vector3(look_vector.y, 0, look_vector.x)
	
	#raycast 1
	raycast.enabled = true
	raycast.position = position
	raycast.target_position = target * 1_000
	raycast.target_position.y = position.y
	raycast.collide_with_areas = true
	raycast.set_collision_mask_value(1, false)
	raycast.set_collision_mask_value(collision_mask, true)
	
	get_tree().get_root().add_child(raycast)
	raycast.force_raycast_update()
	
	if raycast.is_colliding():
		ret[0] = true
		ret[1] = raycast.get_collider()
		ret[2] = raycast.get_collision_point()
	
	if draw:
		ret[3] = Draw3d.line(raycast.position, raycast.get_collision_point())
	
	# bounce
	var ray3D = raycast.get_collision_normal()
	var bouceNormal = Vector2(ray3D.z, ray3D.x)
	
	var bounceLookVector = look_vector.bounce(bouceNormal)
	var bounceRaycast := RayCast3D.new()
	var bounceTarget = Vector3(bounceLookVector.y, 0, bounceLookVector.x)
	
	bounceRaycast.position = raycast.get_collision_point()
	bounceRaycast.target_position = bounceTarget * 1_000
	bounceRaycast.collide_with_areas = true
	raycast.set_collision_mask_value(1, false)
	raycast.set_collision_mask_value(collision_mask, true)
	
	get_tree().get_root().add_child(bounceRaycast)
	bounceRaycast.force_raycast_update()
	
	if bounceRaycast.is_colliding():
		ret[4] = true
		ret[5] = bounceRaycast.get_collider()
		ret[6] = bounceRaycast.get_collision_point()
	
	if draw:
		ret[7] = Draw3d.line(bounceRaycast.position, bounceRaycast.get_collision_point())
	
	raycast.queue_free()
	bounceRaycast.queue_free()
	
	
	return ret

func new_check_direction_bounce(position:Vector3, direction:float, draw=true, collision_mask=2) -> Array:
	# is collideing | collider | collision point | line1 | line2 |
	var ret = [false, null, false, null, null]
	
	var first_ray = check_direction(position, direction, draw, collision_mask)
	
	# bounce
	if first_ray[0]:
		var bouceNormal = Vector2(first_ray[4].z, first_ray[4].x)
		var bounce_look_vector = first_ray[5].bounce(bouceNormal)
		
		var second_ray = check_direction(first_ray[2], direction, draw, collision_mask, bounce_look_vector)
		
		if second_ray[0]:
			ret[0] = true
			ret[1] = second_ray[1]
			ret[2] = second_ray[2]
			ret[3] = second_ray[3]
	
	ret[4] = first_ray[3]
	
	return ret
# sup
