extends Node


func vec2ToVec3(vec2:Vector2, y=0) -> Vector3:
	return Vector3(vec2.y, y, vec2.x)

func vec3ToVec2(vec3:Vector3) -> Vector2:
	return Vector2(vec3.x, vec3.y)
