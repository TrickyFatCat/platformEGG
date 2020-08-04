extends CanvasLayer

onready var pauseLabel: Label = $PauseLabel


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):
        match get_tree().paused:
            true:
                get_tree().paused = false
                pauseLabel.visible = false
                pass
            false:
                get_tree().paused = true
                pauseLabel.visible = true
                pass
