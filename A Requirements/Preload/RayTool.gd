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


