extends KinematicBody2D
class_name Player

export(Vector2) var velocity_max: = Vector2(250.0, 600.0)
export(Vector2) var velocity_jump: = Vector2(325.0, 600.0)
export(Vector2) var velocity_stunlock = Vector2(125.0, 400.0)
export(Vector2) var acceleration: = Vector2(1500.0, 3000.0)
export(float) var ground_friction: = 1700.0

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
