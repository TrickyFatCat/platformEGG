extends Node

const FLOOR_NORMAL: Vector2 = Vector2.UP
const GRAVITY: float = 3000.0

var player: Player
var egg: Egg
var player_hitpoints: int
var egg_hitpoints: int


func deactivate_player() -> void:
	player.is_active = false


func activate_player() -> void:
	player.is_active = true
