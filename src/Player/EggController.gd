extends Node2D
class_name EggController

export(Vector2) var throw_impulse: = Vector2(175, 375)

var is_with_egg: bool = false setget set_is_with_egg
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
	Events.connect("player_took_damage", self, "throw_egg")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("throw"):
		throw_egg()
	
	if event.is_action_pressed("interact") and is_egg_inside:
		take_egg()


func set_is_with_egg(value: bool) -> void:
	is_with_egg = value


func take_egg() -> void:
	if !is_with_egg:
		self.is_with_egg = true
		eggDefaultParent.remove_child(egg)
		player.call_deferred("add_child")
		player.add_child(egg)
		egg.position = eggPosition.position
		egg.is_active = false


func throw_egg() -> void:
	if is_with_egg:
		self.is_with_egg = false
		player.remove_child(egg)
		eggDefaultParent.call_deferred("add_child", egg)
		var facing_direction = -1 if sprite.flip_h else 1
		egg.global_position = eggPosition.global_position
		egg.is_active = true
		egg.throw(facing_direction, throw_impulse)


func disable_input() -> void:
	set_process_unhandled_input(false)


func enable_input() -> void:
	set_process_unhandled_input(true)
