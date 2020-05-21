extends KinematicBody2D
class_name Egg

onready var stateMachine: StateMachine = $StateMachine
onready var move: State = $StateMachine/Move
onready var collider: CollisionPolygon2D = $CollisionPolygon2D

var is_active: bool = true setget set_is_active


func _init() -> void:
	Global.egg = self


func set_is_active(value: bool) -> void:
	is_active = value
	
	if !collider:
		return
	
	collider.disabled = !value
	stateMachine.set_physics_process(value)


func throw(direction_x: float, impulse: Vector2) -> void:
	move.direction = direction_x
	move.velocity.x = impulse.x
	move.velocity.y = -impulse.y
