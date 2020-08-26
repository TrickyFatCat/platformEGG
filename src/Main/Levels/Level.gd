extends Node
class_name Level

export(bool) var is_hud_active: = true

var level_time : float = 0


func _ready() -> void:
	Hud.is_active = is_hud_active
	Events.emit_signal("level_loaded")
