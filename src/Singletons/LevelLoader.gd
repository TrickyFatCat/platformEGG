extends Node

var next_level: String


func _ready() -> void:
	TransitionScreen.connect("screen_closed", self, "load_next_level")


func reload_current_level() -> void:
	get_tree().reload_current_scene()


func load_next_level() -> void:
	if next_level:
		load_level_by_path(next_level)
	else:
		push_error("Next level must be defined")


func load_level_by_path(path: String) -> void:
	get_tree().change_scene(path)
