extends KinematicBody2D
class_name Egg

export(Vector2) var on_damage_impulse = Vector2(200, 300)

var is_active: bool = true setget set_is_active
var velocity: Vector2 = Vector2.ZERO

onready var stateMachine: StateMachine = $StateMachine
onready var collider: CollisionPolygon2D = $CollisionPolygon2D
onready var hitPoints: HitPoints = $HitPoints
onready var flashController: FlashController = $Sprite/FlashController


func _on_DamageDetector_area_entered(area: Area2D) -> void:
	apply_damage()


func _on_DamageDetector_body_entered(body: PhysicsBody2D) -> void:
	apply_damage()


func _on_Sprite_animation_finished() -> void:
	if stateMachine.is_current_state("Death"):
		var target_state = "Inactive"
		stateMachine.transition_to("Inactive")


func _init() -> void:
	Global.egg = self


func _ready() -> void:
	sync_hitpoints()
	Events.connect("player_took_egg", self, "transition_to_carry")
	Events.connect("player_dead", self, "transit_to_death")
	# warning-ignore:return_value_discarded
	hitPoints.connect("damage_taken", self, "start_flash")
	# warning-ignore:return_value_discarded
	hitPoints.connect("invulnerability_lifted", self, "stop_flash")
	hitPoints.connect("hitpoints_zero", self, "transit_to_death")


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


func transition_to_carry() -> void:
	self.is_active = false
	stop_flash()
	stateMachine.transition_to("Carry")


func transit_to_death() -> void:
	if !stateMachine.is_current_state("Death"):
		stateMachine.transition_to("Death")


func apply_damage() -> void:
	hitPoints.decrease_hitpoints()
	sync_hitpoints()
	Events.emit_signal("egg_took_damage") 


func start_flash() -> void:
	flashController.is_active = true


func stop_flash() -> void:
	flashController.is_active = false


func sync_hitpoints() -> void:
	Global.egg_hitpoints = hitPoints.hitpoints





