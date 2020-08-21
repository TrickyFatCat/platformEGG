extends PlayerTrigger

const COLLECT_ANIMATION: String = "collect"

onready var sprite: AnimatedSprite = $AnimatedSprite


func _on_trigger_activated() -> void:
    Events.emit_signal("fruit_earned")
    sprite.play(COLLECT_ANIMATION)
    call_deferred("set", "monitoring", false)



func _on_AnimatedSprite_animation_finished() -> void:
    if sprite.animation == COLLECT_ANIMATION:
        queue_free()


func _ready() -> void:
    pass