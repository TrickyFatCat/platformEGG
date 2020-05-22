extends Node2D
class_name EggController

const EGG_TWEEN_DURATION: float = 0.04

export(Vector2) var throw_impulse: = Vector2(250, 600)
export(Vector2) var damage_throw_impulse: = Vector2(175, 375)

var is_with_egg: bool = false setget set_is_with_egg
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


func set_is_with_egg(value: bool) -> void:
	is_with_egg = value


func take_egg() -> void:
	if !is_with_egg:
		self.is_with_egg = true
		egg.is_active = false
		var egg_last_position = egg.global_position
		eggDefaultParent.remove_child(egg)
		player.call_deferred("add_child")
		player.add_child(egg)
		egg.global_position = egg_last_position
		activate_tween()


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


func drop_egg(impulse: Vector2) -> void:
	if is_with_egg:
		self.is_with_egg = false
		player.remove_child(egg)
		eggDefaultParent.call_deferred("add_child", egg)
		var facing_direction = -1 if sprite.flip_h else 1
		egg.global_position = eggPosition.global_position
		egg.is_active = true
		egg.throw(facing_direction, impulse)


func throw_egg_normal() -> void:
	drop_egg(throw_impulse)


func throw_egg_damage() -> void:
	drop_egg(damage_throw_impulse)


func disable_input() -> void:
	set_process_unhandled_input(false)


func enable_input() -> void:
	set_process_unhandled_input(true)
