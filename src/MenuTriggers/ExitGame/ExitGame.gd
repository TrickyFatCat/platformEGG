extends PlayerTrigger


func _on_trigger_activated() -> void:
    get_tree().quit()