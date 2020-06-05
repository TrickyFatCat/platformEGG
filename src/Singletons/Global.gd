extends Node

const FLOOR_NORMAL: Vector2 = Vector2.UP
const GRAVITY: float = 3000.0

var player: Player
var egg: Egg


func deactivate_player() -> void:
	player.is_active = false


func activate_player() -> void:
	player.is_active = true
