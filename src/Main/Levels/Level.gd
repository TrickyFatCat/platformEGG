extends Node
class_name Level

export(bool) var is_hud_active := true
export(Vector2) var camera_zoom := Vector2(1, 1)

var level_time : float = 0


func _init() -> void:
	Global.current_level = self


func _ready() -> void:
	GlobalCamera.zoom = camera_zoom
	Hud.is_active = is_hud_active
	Events.emit_signal("level_loaded")
