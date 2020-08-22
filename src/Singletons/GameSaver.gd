extends Node

var game_data = "user://game_data.save"


func _ready() -> void:
    Events.connect("level_finished", self, "save_game")


func save_game() -> void:
    var file = File.new()
    file.open(game_data, File.WRITE)
    file.store_var(LevelLoader.levels_data)
    file.close()
    print_debug("Game Saved")
    pass


func load_game() -> Array:
    var levels_data
    var file = File.new()
    if file.file_exists(game_data):
        file.open(game_data, File.READ)
        levels_data = file.get_var()
        file.close()
    print_debug("Game Loaded")
    return levels_data