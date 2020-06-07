extends Node2D
class_name EggController

export(Vector2) var throw_impulse: = Vector2(300, 625)
export(Vector2) var drop_impulse: = Vector2(200, 600)

var is_egg_inside: bool = false

onready var player_sprite: AnimatedSprite = Global.player.get_node("Sprite")
onready var egg: Egg = Global.egg
onready var eggPosition: Position2D = $EggPosition
onready var eggDefaultParent: Node = Global.egg.get_parent()


# warning-ignore:unused_argument
func _on_EggDetector_body_entered(body: KinematicBody2D) -> void:
	is_egg_inside = true


# warning-ignore:unused_argument
func _on_EggDetector_body_exited(body: KinematicBody2D) -> void:
	is_egg_inside = false


func _ready() -> void:
# warning-ignore:return_value_discarded
	Events.connect("player_took_damage", self, "drop_egg")


func take_egg() -> void:
	if !Global.player.is_with_egg and is_egg_inside:
		Events.emit_signal("player_took_egg")
		switch_egg_parent(true)


# warning-ignore:shadowed_variable
func throw_egg(throw_impulse: Vector2) -> void:
	if Global.player.is_with_egg:
		Events.emit_signal("player_threw_egg")
		switch_egg_parent(false)
		egg.call_deferred("throw", throw_impulse, get_throw_direction())


func switch_egg_parent(is_with_egg: bool) -> void:
	Global.player.is_with_egg = is_with_egg
	
	if is_with_egg:
		eggDefaultParent.remove_child(egg)
		egg.position = eggPosition.position
		Global.player.call_deferred("add_child", egg)
	else:
		Global.player.remove_child(egg)
		egg.global_position = eggPosition.global_position
		eggDefaultParent.call_deferred("add_child", egg)


func drop_egg() -> void:
	if Global.player.is_with_egg:
		throw_egg(drop_impulse)


func get_throw_direction() -> Vector2:
	var facing_direction: = -1 if player_sprite.flip_h else 1
	return Vector2(facing_direction, 1)
