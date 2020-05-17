extends Node
class_name EggController

var is_with_egg: bool = false setget set_is_with_egg
var is_egg_inside: bool = false

onready var eggDetector: Area2D = get_node("../EggDetector")
onready var eggSprite: Sprite = get_node("../EggSprite")


func _on_EggDetector_body_entered(body):
	is_egg_inside = true


func _on_EggDetector_body_exited(body):
	is_egg_inside = false


func _on_DamageDetector_area_entered(area):
	throw_egg()


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
	eggSprite.visible = true if is_with_egg else false


func take_egg() -> void:
	self.is_with_egg = true


func throw_egg() -> void:
	self.is_with_egg = false



