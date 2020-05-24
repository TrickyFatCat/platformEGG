extends KinematicBody2D
class_name Player

onready var stateMachine: StateMachine = $StateMachine
onready var collider: CollisionShape2D = $CollisionShape2D

var is_active: bool = true setget set_is_active


func _init() -> void:
	Global.player = self


func set_is_active(value: bool) -> void:
	is_active = value
	
	if !collider:
		return
	
	collider.disabled = !value
