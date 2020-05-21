extends Node
class_name EggController

var is_with_egg: bool = false setget set_is_with_egg
var is_egg_inside: bool = false

onready var player: Player = Global.player
onready var egg: Egg = Global.egg
onready var eggDetector: Area2D = get_node("../EggDetector")
onready var eggPosition: Position2D = get_node("../EggPosition")
onready var eggDefaultParent: Node = Global.egg.get_parent()


func _on_EggDetector_body_entered(body: KinematicBody2D) -> void:
	is_egg_inside = true


func _on_EggDetector_body_exited(body: KinematicBody2D) -> void:
	is_egg_inside = false


func _on_DamageDetector_area_entered(area):
	if is_with_egg:
		throw_egg()


func _ready() -> void:
	Events.connect("player_stunlock_entered", self, "disable_input")
	Events.connect("player_stunlock_exited", self, "enable_input")
	pass


func _unhandled_input(event: InputEvent) -> void:
	match is_with_egg:
		true:
			if event.is_action_pressed("throw"):
				throw_egg()
		false:
			if event.is_action_pressed("interact") and is_egg_inside:
				take_egg()


func set_is_with_egg(value: bool) -> void:
	is_with_egg = value


func take_egg() -> void:
	self.is_with_egg = true
	eggDefaultParent.remove_child(egg)
	player.add_child(egg)
	egg.position = eggPosition.position
	egg.is_active = false


func throw_egg() -> void:
	self.is_with_egg = false
	player.remove_child(egg)
	eggDefaultParent.call_deferred("add_child", egg)
	egg.global_position = eggPosition.global_position
	egg.is_active = true
	egg.throw(-1, Vector2(400, 300))


func disable_input() -> void:
	set_process_unhandled_input(false)


func enable_input() -> void:
	set_process_unhandled_input(true)
