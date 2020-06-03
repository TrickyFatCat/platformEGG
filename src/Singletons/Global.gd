extends Node

const FLOOR_NORMAL: Vector2 = Vector2.UP
const GRAVITY: float = 3000.0

var player: Player
var egg: Egg


static func clamp_vector2(original_vector: Vector2, min_vector: Vector2, max_vector: Vector2) -> Vector2:
	original_vector.x = clamp(original_vector.x, min_vector.x, max_vector.x)
	original_vector.y = clamp(original_vector.y, min_vector.y, max_vector.y)
	return original_vector
