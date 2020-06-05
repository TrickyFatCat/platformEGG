extends Node


func _ready() -> void:
	Events.emit_signal("level_loaded")
