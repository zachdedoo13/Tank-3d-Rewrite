extends Node


func check_direction(position:Vector3, direction:float, draw=true, collision_mask=2) -> Array:
	var ret = [false, false, false, false]
	
	direction += PI
	
	var raycast := RayCast3D.new()
	var look_vector = Vector2(cos(direction), sin(direction))
	var target = Vector3(look_vector.y, 0, look_vector.x)
	
	raycast.enabled = true
	raycast.position = position
	raycast.target_position = target * 1_000
	raycast.target_position.y = position.y
	raycast.collide_with_areas = true
	raycast.collision_mask = collision_mask
	
	get_tree().get_root().add_child(raycast)
	raycast.force_raycast_update()
	
	if raycast.is_colliding():
		ret[0] = true
		ret[1] = raycast.get_collider()
		ret[2] = raycast.get_collision_point()
		
	raycast.queue_free()
		
	if draw:
		var line = 0
		if ret[0] == true:
			line = Draw3d.line(raycast.position, ret[2])
		else:
			line = Draw3d.line(raycast.position, raycast.target_position)
		ret[3] = line
		
	return ret

func check_direction_bounce(position:Vector3, direction:float, draw=true, collision_mask=2) -> Array:
	var ret = [false, false, false, false]
	
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
	raycast.collision_mask = collision_mask
	
	get_tree().get_root().add_child(raycast)
	raycast.force_raycast_update()
	
	ret[0] = Draw3d.line(raycast.position, raycast.get_collision_point())
	
	# bounce
	var ray3D = raycast.get_collision_normal()
	var bouceNormal = Vector2(ray3D.z, ray3D.x)
	
	var bounceLookVector = look_vector.bounce(bouceNormal)
	var bounceRaycast := RayCast3D.new()
	var bounceTarget = Vector3(bounceLookVector.y, 0, bounceLookVector.x)
	
	bounceRaycast.position = raycast.get_collision_point()
	bounceRaycast.target_position = bounceTarget * 1_000
	bounceRaycast.collide_with_areas = true
	bounceRaycast.collision_mask = collision_mask
	
	get_tree().get_root().add_child(bounceRaycast)
	bounceRaycast.force_raycast_update()
	
	ret[1] = Draw3d.line(bounceRaycast.position, bounceRaycast.get_collision_point())
	
	raycast.queue_free()
	bounceRaycast.queue_free()
	
	return ret

func check_position(position:Vector3, draw=true, collision_mask=2) -> Array:
	var ret = []
	return ret

func check_2_positions(pos1:Vector3, pos2:Vector3, draw=true, collision_mask=2) -> Array:
	var ret = []
	return ret


