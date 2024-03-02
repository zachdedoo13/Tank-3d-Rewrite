extends Node3D

var mouse_pos = Vector3(0, 0, 0)

func _ready() -> void:
	SignalManager.MousePos.connect(get_mouse_pos)

func get_mouse_pos(pos) -> void:
	mouse_pos = Vector3(pos.x, global_position.y, pos.z)
	look_at(mouse_pos)

func _process(delta) -> void:
	if Input.is_action_just_pressed("left_click"):
		shoot()

func shoot() -> void:
	SignalManager.SpawnBullet.emit("bacic", "player", $Marker3D.global_position, rotation.y - PI, 30, false)
