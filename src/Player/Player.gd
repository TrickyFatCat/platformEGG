extends KinematicBody2D
class_name Player

export(Vector2) var velocity_max: = Vector2(250.0, 600.0)
export(Vector2) var velocity_jump: = Vector2(325.0, 600.0)
export(Vector2) var velocity_stunlock = Vector2(125.0, 400.0)
export(Vector2) var acceleration: = Vector2(1500.0, 3000.0)
export(float) var ground_friction: = 1700.0
export(float) var air_friction: = 850.0
export(float, 0, 10) var air_control_factor: = 8

var is_with_egg: bool = false
var is_active: bool = true setget set_is_active

onready var stateMachine: StateMachine = $StateMachine
onready var collider: CollisionShape2D = $CollisionShape2D
onready var flashController: FlashController = $Sprite/FlashController
onready var hitPoints: HitPoints = $HitPoints
onready var eggController: EggController = $EggController


# warning-ignore:unused_argument
func _on_DamageDetector_area_entered(area: Area2D) -> void:
	apply_damage()


# warning-ignore:unused_argument
func _on_DamageDetector_body_entered(body: PhysicsBody2D) -> void:
	apply_damage()


func _on_Sprite_animation_finished() -> void:
	var target_state: String
	
	if stateMachine.is_current_state("Stunlock"):
		if Global.player_hitpoints > 0:
			target_state = "Move/Idle" if is_on_floor() else "Move/Fall"
		else:
			target_state = "Death"
	
	if stateMachine.is_current_state("Death"):
		target_state = "Inactive"
	
	if target_state:
		stateMachine.transition_to(target_state)


func _init() -> void:
	Global.player = self


func _ready() -> void:
	self.is_active = false
	sync_hitpoints()
# warning-ignore:return_value_discarded
	hitPoints.connect("damage_taken", self, "start_flash")
# warning-ignore:return_value_discarded
	hitPoints.connect("invulnerability_lifted", self, "stop_flash")
	Events.connect("egg_dead", self, "transit_to_death")


func set_is_active(value: bool) -> void:
	is_active = value
	
	if !collider:
		return

	$DamageDetector/CollisionShape2D.disabled = !value
	stateMachine.set_process_unhandled_input(value)
	$EggController.set_process_unhandled_input(value)


func apply_damage() -> void:
	hitPoints.decrease_hitpoints()
	sync_hitpoints()
	Events.emit_signal("player_took_damage")


func start_flash() -> void:
	flashController.is_active = true


func stop_flash() -> void:
	flashController.is_active = false


func take_egg() -> void:
	eggController.take_egg()


func throw_egg() -> void:
	eggController.throw_egg(eggController.throw_impulse) 


func sync_hitpoints() -> void:
	Global.player_hitpoints = hitPoints.hitpoints


func transit_to_death() -> void:
	if !stateMachine.is_current_state("Death"):
		stateMachine.transition_to("Death")
