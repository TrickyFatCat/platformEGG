extends State


# warning-ignore:unused_argument
func unhandled_input(event: InputEvent) -> void:
	return


# warning-ignore:unused_argument
func physics_process(delta: float) -> void:
	return


# warning-ignore:unused_argument
func enter(msg: Dictionary = {}) -> void:
	GameManager.emit_signal("game_started")


func exit() -> void:
	return
