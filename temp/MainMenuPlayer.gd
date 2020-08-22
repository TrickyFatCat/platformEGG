extends AudioStreamPlayer


func _ready() -> void:
    Events.connect("level_loaded", self, "start_playing")


func start_playing() -> void:
    playing = true