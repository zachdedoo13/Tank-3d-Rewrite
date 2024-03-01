extends CSGBox3D


func shoot(mouse_pos):
	SignalManager.SpawnBullet.emit("bacic", "player", $Marker3D.global_position, 0, 30, false)
