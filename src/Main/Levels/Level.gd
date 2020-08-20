extends Node
class_name GameLevel

export(bool) var is_hud_active: = true
export(bool) var load_custom_level: = false
export(String, FILE, "*.tscn") var next_level: = ""

var fruits_gained: int = 0


func _get_configuration_warning() -> String:
	var warning: String = "Next level must be chosen."
	return warning if !next_level and load_custom_level else ""


func _ready() -> void:
	if !Engine.editor_hint:
		Hud.is_active = is_hud_active
		Events.emit_signal("level_loaded")

		if load_custom_level:
			LevelLoader.next_level = next_level
			LevelLoader.current_level = self.name
		else:
			LevelLoader.set_next_level()
	
