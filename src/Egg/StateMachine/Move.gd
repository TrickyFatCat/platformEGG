extends State

const BOUNCE_FACTOR: Vector2 = Vector2(0.35, 0.5)
const WALL_BOUNCE_FACTOR: Vector2 = Vector2(0.35, 1)
const SNAP_VECTOR_DEFAULT : Vector2 = Vector2.DOWN * 2

var gravity: float = Global.GRAVITY
var velocity: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.ZERO

onready var egg: Egg = Global.egg
onready var on_damage_impulse: Vector2 = egg.on_damage_impulse


func _on_DamageDetector_area_entered(area: Area2D) -> void:
	if area is DeathTrigger:
		Global.egg.global_position = area.teleportation_position
		
	on_damage_throw(area.global_position)


func _on_DamageDetector_body_entered(body: PhysicsBody2D) -> void:
	on_damage_throw(body.global_position)


func physics_process(delta: float) -> void:
	apply_gravity(delta)
	egg.move_and_slide_with_snap(velocity, SNAP_VECTOR_DEFAULT, Global.FLOOR_NORMAL)


func enter(msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	pass


func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta


func apply_bounce() -> void:
	if egg.is_on_floor() or egg.is_on_ceiling():
		velocity.y *= -BOUNCE_FACTOR.y
		velocity.x *= BOUNCE_FACTOR.x
	
	if egg.is_on_wall():
		velocity.x *= -WALL_BOUNCE_FACTOR.x
	
	egg.velocity = velocity


func on_damage_throw(hazard_position: Vector2) -> void:
	if direction == Vector2.ZERO:
		var is_hazard_beneath = hazard_position.y <= egg.global_position.y
		direction.x = sign(velocity.x) if is_hazard_beneath else -sign(velocity.x)
		direction.y = 1 if is_hazard_beneath else -1
	
	if Global.egg_hitpoints > 0:
		stateMachine.transition_to("Move/Soar", { velocity = on_damage_impulse, direction = direction })
