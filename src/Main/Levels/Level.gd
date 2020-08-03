extends Node
class_name GameLevel

export(bool) var load_custom_level: = false
export(String, FILE, "*.tscn") var next_level: = ""


func _get_configuration_warning() -> String:
	var warning: String = "Next level must be chosen."
	return warning if !next_level and load_custom_level else ""


func _ready() -> void:
	if !Engine.editor_hint:
		Events.emit_signal("level_loaded")

		if load_custom_level:
			LevelLoader.next_level = next_level
			LevelLoader.current_level = self.name
		else:
			LevelLoader.next_level_id = LevelLoader.current_level_id + 1
			LevelLoader.current_level_id = LevelLoader.next_level_id
			LevelLoader.next_level = LevelLoader.levels[LevelLoader.next_level_id]
