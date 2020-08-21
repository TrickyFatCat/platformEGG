extends Node


func _ready() -> void:
    Events.connect("level_finished", self, "save_game")


func save_game() -> void:
    print_debug("Game Saved")
    pass


func load_game() -> void:
    print_debug("Game Loaded")
    pass