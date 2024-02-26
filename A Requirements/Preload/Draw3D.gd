extends Node


func point(pos:Vector3, radius = 0.5, color = Color.WHITE_SMOKE) -> MeshInstance3D:
	# declare objects
	var mesh_instance := MeshInstance3D.new()
	var sphere_mesh := SphereMesh.new()
	var material := ORMMaterial3D.new()
	
	# object settings
	mesh_instance.mesh = sphere_mesh
	#mesh_instance.cast_shadow = false
	mesh_instance.position = pos
	
	# change mesh
	sphere_mesh.radius = radius
	sphere_mesh.height = radius * 2
	sphere_mesh.material = material
	
	# shadeing
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	
	get_tree().get_root().add_child(mesh_instance)
	
	return mesh_instance


func line(pos1:Vector3, pos2:Vector3, color = Color.WHITE_SMOKE) -> MeshInstance3D:
	# declare objects
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	#mesh_instance.cast_shadow = false
	
	# draw line
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(pos1)
	immediate_mesh.surface_add_vertex(pos2)
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	
	get_tree().get_root().add_child(mesh_instance)
	
	return mesh_instance
