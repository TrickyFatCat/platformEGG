extends Node2D
class_name EggController

const EGG_TWEEN_DURATION: float = 0.0075

export(Vector2) var throw_distance: = Vector2(128, 64)
export(Vector2) var drop_distance: = Vector2(32, 32)

var is_with_egg: bool = false
var is_egg_inside: bool = false

onready var player: Player = Global.player
onready var sprite: Sprite = get_node("../Sprite")
onready var egg: Egg = Global.egg
onready var eggDetector: Area2D = $EggDetector
onready var eggPosition: Position2D = $EggPosition
onready var eggTween: Tween = $EggTween
onready var eggDefaultParent: Node = Global.egg.get_parent()


func _on_EggDetector_body_entered(body: KinematicBody2D) -> void:
	is_egg_inside = true


func _on_EggDetector_body_exited(body: KinematicBody2D) -> void:
	is_egg_inside = false


func _ready() -> void:
	Events.connect("player_stunlock_entered", self, "disable_input")
	Events.connect("player_stunlock_exited", self, "enable_input")
	Events.connect("player_took_damage", self, "throw_egg_damage")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("throw"):
		throw_egg_normal()
	
	if event.is_action_pressed("interact") and is_egg_inside:
		take_egg()


func take_egg() -> void:
	if !is_with_egg:
		is_with_egg = true
		egg.is_active = false
		var egg_last_position = egg.global_position
		switch_egg_parent(is_with_egg)
		egg.global_position = egg_last_position
		egg.position = eggPosition.position

func activate_tween() -> void:
	eggTween.interpolate_property(
		egg, "global_position",
		egg.global_position,
		eggPosition.global_position,
		EGG_TWEEN_DURATION, 
		Tween.TRANS_LINEAR, 
		Tween.EASE_IN
	)
	eggTween.start()


func drop_egg(throw_distance: Vector2) -> void:
	if is_with_egg:
		is_with_egg = false
		switch_egg_parent(is_with_egg)
		egg.global_position = eggPosition.global_position
		egg.is_active = true
		var facing_direction: = 1 if sprite.flip_h else -1
		var direction: = Vector2(facing_direction, 1)
		egg.call_deferred("throw", eggPosition.global_position, direction, throw_distance)


func switch_egg_parent(is_parent_player: bool) -> void:
	if is_parent_player:
		eggDefaultParent.remove_child(egg)
		player.call_deferred("add_child", egg)
	else:
		player.remove_child(egg)
		eggDefaultParent.call_deferred("add_child", egg)


func throw_egg_normal() -> void:
	drop_egg(throw_distance)


func throw_egg_damage() -> void:
	drop_egg(drop_distance)


func disable_input() -> void:
	set_process_unhandled_input(false)


func enable_input() -> void:
	set_process_unhandled_input(true)
