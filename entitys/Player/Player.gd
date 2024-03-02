extends Node3D



# set the turrents position to the tanks position
func _process(delta) -> void:
	var y = $Turrent.global_position.y
	$Turrent.global_position = $Body/CharacterBody3D.global_position
	$Turrent.global_position.y = y
