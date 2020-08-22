extends GameLevel


func _init() -> void:
    LevelLoader.levels_data = GameSaver.load_game()

