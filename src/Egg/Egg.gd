extends KinematicBody2D
class_name Egg

const DAMAGE_THROW_IMPULSE: Vector2 = Vector2(200, 300)

onready var stateMachine: StateMachine = $StateMachine
onready var collider: CollisionPolygon2D = $CollisionPolygon2D

var is_active: bool = true setget set_is_active


func _on_DamageDetector_area_entered(area: Area2D) -> void:
	apply_throw(area.global_position)


func _on_DamageDetector_body_entered(body: PhysicsBody2D) -> void:
	apply_throw(body.global_position)


func _init() -> void:
	Global.egg = self


func set_is_active(value: bool) -> void:
	is_active = value
	
	if !collider:
		return
	
	collider.disabled = !value
	stateMachine.set_physics_process(value)


func apply_throw(target_position: Vector2) -> void:
	var direction: = Vector2(1.0, 1.0)
	direction.x = sign((target_position - global_position).normalized().x)
	direction.y = -1 if target_position.y < global_position.y else 1
	throw(DAMAGE_THROW_IMPULSE, direction)


func throw(throw_velocity: Vector2, throw_direction: Vector2) -> void:
	throw_direction.y = -1
	stateMachine.transition_to("Move/Throw", { velocity = throw_velocity, direction = throw_direction })
	pass











