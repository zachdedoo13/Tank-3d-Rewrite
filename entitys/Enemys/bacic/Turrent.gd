extends Node3D

var line = []
var line2 = []
var can_shoot = true


func look_and_check() -> void:
	var store = RayTool.new_check_direction_bounce(global_position, rotation.y, true, 5)
	if store[0]:
		if store[1].is_in_group("player"):
			if can_shoot:
				shoot()
				$Timer.start()
				can_shoot = false
	line.append(store[3])
	line2.append(store[4])
	
	RayTool.clear_check_direction(line)
	RayTool.clear_check_direction(line2)

func shoot() -> void:
	SignalManager.SpawnBullet.emit("bacic", "player", $Marker3D.global_position, rotation.y - PI, 30, false)


func _on_timer_timeout():
	can_shoot = true
