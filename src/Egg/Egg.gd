extends KinematicBody2D
class_name Egg

export(Vector2) var on_damage_impulse = Vector2(200, 300)

var is_active: bool = true setget set_is_active
var velocity: Vector2 = Vector2.ZERO

onready var stateMachine: StateMachine = $StateMachine
onready var collider: CollisionPolygon2D = $CollisionPolygon2D


func _on_DamageDetector_area_entered(area: Area2D) -> void:
	Events.emit_signal("egg_took_damage", area.global_position)


func _on_DamageDetector_body_entered(body: PhysicsBody2D) -> void:
	Events.emit_signal("egg_took_damage", body.global_position)


func _init() -> void:
	Global.egg = self


func set_is_active(value: bool) -> void:
	is_active = value
	
	if !collider:
		return
	
	collider.disabled = !value
	stateMachine.set_physics_process(value)


func throw(throw_velocity: Vector2, throw_direction: Vector2) -> void:
	throw_direction.y = -1
	stateMachine.transition_to("Move/Soar", { velocity = throw_velocity, direction = throw_direction })
	yield(get_tree(), "idle_frame")
	self.is_active = true











