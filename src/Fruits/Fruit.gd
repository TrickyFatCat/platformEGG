extends PlayerTrigger

const COLLECT_ANIMATION: String = "collect"
const FRUITS_ANIMATIONS : Array = [
    "apple",
    "bananas",
    "cherries",
    "kiwi",
    "melon",
    "orange",
    "pineapple",
    "strawberry"
]

onready var sprite: AnimatedSprite = $AnimatedSprite


func _on_trigger_activated() -> void:
    Events.emit_signal("fruit_earned")
    sprite.play(COLLECT_ANIMATION)
    call_deferred("set", "monitoring", false)


func _on_AnimatedSprite_animation_finished() -> void:
    if sprite.animation == COLLECT_ANIMATION:
        queue_free()


func _ready() -> void:
    var fruit_animation = FRUITS_ANIMATIONS[randi() % FRUITS_ANIMATIONS.size()]
    sprite.play(fruit_animation)
    sprite.playing = true
    pass