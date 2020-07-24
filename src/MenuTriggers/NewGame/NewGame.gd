extends PlayerTrigger

enum difficulty{
    NORMAL,
    HARD
}

export(difficulty) var game_difficulty = difficulty.NORMAL 


func _on_trigger_activated() -> void:
    GameManager.stop_session()
    GameManager.game_difficulty = difficulty