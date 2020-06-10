extends State

onready var sprite: AnimatedSprite = Global.player.get_node("Sprite")


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func enter(msg: Dictionary = {}) -> void:
	if stateMachine.is_previous_state("Death"):
		Events.emit_signal("player_dead")
	
	sprite.play("inactive")


func exit() -> void:
	pass
