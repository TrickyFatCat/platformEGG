extends State


func unhandled_input(event: InputEvent) -> void:
	return


func enter(msg: Dictionary = {}) -> void:
	Hud.emit_signal("finish_screen_opened")


func exit() -> void:
	return
