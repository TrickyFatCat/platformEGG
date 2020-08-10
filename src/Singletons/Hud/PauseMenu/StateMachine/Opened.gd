extends State


func unhandled_input(event: InputEvent) -> void:
	return


func enter(msg: Dictionary = {}) -> void:
	Hud.emit_signal("pause_menu_opened")


func exit() -> void:
	return
