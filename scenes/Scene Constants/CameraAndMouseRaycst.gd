extends Node3D

var ray_start = Vector3()
var ray_target = Vector3()

func _physics_process(delta):
	
	$Label.text = str(Engine.get_frames_per_second())
	
	var space_state = get_world_3d().direct_space_state
	
	var mouse = get_viewport().get_mouse_position()
	
	ray_start = $Camera3D.project_ray_origin(mouse)
	
	ray_target = ray_start + $Camera3D.project_ray_normal(mouse) * 2000
	
	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_target)
	query.collision_mask = 1
	var inter = space_state.intersect_ray(query)
	
	if not inter.is_empty():
		var pos = inter.position
		SignalManager.MousePos.emit(pos)
