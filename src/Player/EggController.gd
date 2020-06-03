extends Node2D
class_name EggController

export(Vector2) var throw_impulse: = Vector2(300, 625)
export(Vector2) var drop_impulse: = Vector2(200, 600)

var is_egg_inside: bool = false

onready var player: Player = Global.player
onready var player_sprite: AnimatedSprite = player.get_node("Sprite")
onready var egg: Egg = Global.egg
onready var eggPosition: Position2D = $EggPosition
onready var eggDefaultParent: Node = Global.egg.get_parent()


func _on_EggDetector_body_entered(body: KinematicBody2D) -> void:
	is_egg_inside = true


func _on_EggDetector_body_exited(body: KinematicBody2D) -> void:
	is_egg_inside = false


func _ready() -> void:
	Events.connect("player_stunlock_entered", self, "disable_input")
	Events.connect("player_stunlock_exited", self, "enable_input")
	Events.connect("player_took_damage", self, "drop_egg")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("throw"):
		throw_egg(throw_impulse)
	
	if event.is_action_pressed("interact") and is_egg_inside:
		take_egg()


func take_egg() -> void:
	if !player.is_with_egg:
		Events.emit_signal("player_took_egg")
		switch_egg_parent(true)


func throw_egg(throw_impulse: Vector2) -> void:
	if player.is_with_egg:
		Events.emit_signal("player_threw_egg")
		switch_egg_parent(false)
		egg.call_deferred("throw", throw_impulse, get_throw_direction())


func switch_egg_parent(is_with_egg: bool) -> void:
	player.is_with_egg = is_with_egg
	
	if is_with_egg:
		eggDefaultParent.remove_child(egg)
		egg.position = eggPosition.position
		player.call_deferred("add_child", egg)
	else:
		player.remove_child(egg)
		egg.global_position = eggPosition.global_position
		eggDefaultParent.call_deferred("add_child", egg)


func drop_egg() -> void:
	throw_egg(drop_impulse)


func get_throw_direction() -> Vector2:
	var facing_direction: = -1 if player_sprite.flip_h else 1
	return Vector2(facing_direction, 1)


func disable_input() -> void:
	set_process_unhandled_input(false)


func enable_input() -> void:
	set_process_unhandled_input(true)
