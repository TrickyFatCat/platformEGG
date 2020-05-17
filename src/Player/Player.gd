extends KinematicBody2D
class_name Player

const FLOOR_NORMAL: Vector2 = Vector2.UP

var is_with_egg: bool = false

onready var StateMachineNode: StateMachine = $StateMachine
onready var Collider: CollisionShape2D = $CollisionShape2D

var is_active: bool = true setget set_is_active


func set_is_active(value: bool) -> void:
	is_active = value
	
	if !Collider:
		return
	
	Collider.disabled = !value
