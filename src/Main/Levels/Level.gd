extends Node
class_name Level

export(bool) var is_hud_active: = true


func _ready() -> void:
	if !Engine.editor_hint:
		Hud.is_active = is_hud_active
		Events.emit_signal("level_loaded")
	
