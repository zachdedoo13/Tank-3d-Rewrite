extends CharacterBody3D

@export var HEALTH : int

func check_hit(object) -> void:
	if object == self:
		print("hit enemy")
		HEALTH -= 1
		if HEALTH <= 0:
			get_parent().get_parent().queue_free()

func _ready() -> void:
	SignalManager.BulletHit.connect(check_hit)
