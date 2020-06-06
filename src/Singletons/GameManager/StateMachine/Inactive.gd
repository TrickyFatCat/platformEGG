extends State


func unhandled_input(event: InputEvent) -> void:
	return


func physics_process(delta: float) -> void:
	return


func enter(msg: Dictionary = {}) -> void:
	Global.call_deferred("deactivate_player")
	return


func exit() -> void:
	return
