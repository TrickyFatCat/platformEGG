extends State

onready var player: Player = Global.player
onready var sprite: AnimatedSprite = player.get_node("Sprite")


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func enter(msg: Dictionary = {}) -> void:
	sprite.play("spawn")


func exit() -> void:
	player.is_active = true
