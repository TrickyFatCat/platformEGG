extends KinematicBody2D

onready var tween: Tween = $Tween
onready var start: Vector2 = get_node("Node/Position2D").global_position
onready var end: Vector2 = get_node("Node/Position2D2").global_position

func _ready() -> void:
	yield(get_tree().create_timer(2), "timeout")
	tween.interpolate_property(self, "position", start, end, 4, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
