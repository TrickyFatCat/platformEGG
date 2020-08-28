extends Node

const FLOOR_NORMAL: Vector2 = Vector2.UP
const GRAVITY: float = 3000.0

var player: Player
var egg: Egg
var player_hitpoints: int
var egg_hitpoints: int
var current_level : Level


func deactivate_player() -> void:
	if player:
		player.is_active = false


func activate_player() -> void:
	if player:
		player.is_active = true