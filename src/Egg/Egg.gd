extends KinematicBody2D
class_name Egg

const DAMAGE_THROW_IMPULSE: Vector2 = Vector2(32, 32)

onready var stateMachine: StateMachine = $StateMachine
onready var move: State = $StateMachine/Move
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


func apply_throw(target_direction: Vector2) -> void:
	var direction: = Vector2.ZERO
	direction.x = 1 if move.velocity.x > 0 else -1
	direction.y = -1 if target_direction.y <= global_position.y else 1
	throw(global_position, direction, DAMAGE_THROW_IMPULSE)


func throw(start_point: Vector2, direction: Vector2, throw_distance: Vector2) -> void:
	var target_point : = start_point + Vector2(throw_distance.x, 0)
	var arc_height = target_point.y - global_position.y - throw_distance.y
	arc_height = min(arc_height, -throw_distance.y)
	move.velocity = calculate_velocity(start_point, target_point, arc_height)
	move.velocity.x *= direction.x
	move.velocity.y *= direction.y
	stateMachine.transition_to("Move/Fall")


static func calculate_velocity(
		start_point: Vector2, 
		target_point: Vector2, 
		arc_height: float, 
		up_gravity: float = Global.GRAVITY,
		down_gravity: float = -1
	):
	if down_gravity == -1:
		down_gravity = up_gravity
	
	var velocity: = Vector2.ZERO
	var displacement: = start_point - target_point
	var time_up = sqrt(-2 * arc_height / up_gravity)
	var time_down = sqrt(2 * (displacement.y - arc_height) / down_gravity)
	velocity.y = -sqrt(-2 * up_gravity * arc_height)
	velocity.x = displacement.x / float(time_up + time_down)

	return velocity
