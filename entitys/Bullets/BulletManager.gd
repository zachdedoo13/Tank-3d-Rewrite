extends Node

@export var bacic : PackedScene

func _ready():
	SignalManager.SpawnBullet.connect(spawn_bullet)

func spawn_bullet(type, shot_from, pos, dir, speed, bounce):
	if type == "bacic":
		var bullet = bacic.instantiate()
		bullet.start(pos, dir, speed, bounce)
		add_child(bullet)
