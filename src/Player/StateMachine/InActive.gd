extends State


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func enter(msg: Dictionary = {}) -> void:
	Events.emit_signal("player_dead")


func exit() -> void:
	pass
