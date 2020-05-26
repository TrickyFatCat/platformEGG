extends Node2D
class_name EggController

export(Vector2) var throw_distance: = Vector2(128, 64)
export(Vector2) var drop_distance: = Vector2(32, 32)

var is_egg_inside: bool = false

onready var player: Player = Global.player
onready var sprite: Sprite = get_node("../Sprite")
onready var egg: Egg = Global.egg
onready var eggDetector: Area2D = $EggDetector
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
		throw_egg(throw_distance)
	
	if event.is_action_pressed("interact") and is_egg_inside:
		take_egg()


func take_egg() -> void:
	if !player.is_with_egg:
		player.is_with_egg = true
		egg.is_active = false
		switch_egg_parent(player.is_with_egg)
		var egg_last_position = egg.global_position
		egg.global_position = egg_last_position
		egg.position = eggPosition.position


func throw_egg(throw_distance: Vector2) -> void:
	if player.is_with_egg:
		player.is_with_egg = false
		switch_egg_parent(player.is_with_egg)
		var facing_direction: = 1 if sprite.flip_h else -1
		var direction: = Vector2(facing_direction, 1)
		egg.global_position = eggPosition.global_position
		egg.is_active = true
		egg.call_deferred("throw", eggPosition.global_position, direction, throw_distance)


func switch_egg_parent(is_parent_player: bool) -> void:
	if is_parent_player:
		eggDefaultParent.remove_child(egg)
		player.call_deferred("add_child", egg)
	else:
		player.remove_child(egg)
		eggDefaultParent.call_deferred("add_child", egg)


func drop_egg() -> void:
	throw_egg(drop_distance)


func disable_input() -> void:
	set_process_unhandled_input(false)


func enable_input() -> void:
	set_process_unhandled_input(true)
