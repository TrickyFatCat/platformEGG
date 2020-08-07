extends CanvasLayer

var is_active: bool = false

onready var pauseMenu: Control = $PauseMenu


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel") and is_active:
        match get_tree().paused:
            true:
                get_tree().paused = false
                pauseMenu.visible = false
                pass
            false:
                get_tree().paused = true
                pauseMenu.visible = true
                pass
