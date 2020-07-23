extends PlayerTrigger


func _on_trigger_activated() -> void:
    GameManager.stop_session()