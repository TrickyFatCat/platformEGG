extends State


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		TransitionScreen.start_transition()
	return


func enter(msg: Dictionary = {}) -> void:
	return


func exit() -> void:
	return
