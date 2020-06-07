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


func _on_DamageDetector_area_entered(area: Area2D) -> void:
	apply_damage()


func _on_DamageDetector_body_entered(body: PhysicsBody2D) -> void:
	apply_damage()


func _on_Sprite_animation_finished() -> void:
	var target_state
	
	if stateMachine.is_current_state("Stunlock"):
		if Global.player_hitpoints > 0:
			target_state = "Move/Idle" if is_on_floor() else "Move/Fall"
		else:
			target_state = "Death"
	
	if stateMachine.is_current_state("Death"):
		target_state = "Inactive"
		Events.emit_signal("player_dead")
	
	if target_state:
		stateMachine.transition_to(target_state)


func _init() -> void:
	Global.player = self


func _ready() -> void:
	self.is_active = false
	Global.player_hitpoints = hitPoints.hitpoints
	hitPoints.connect("damage_taken", self, "start_flash")
	hitPoints.connect("invulnerability_lifted", self, "stop_flash")


func set_is_active(value: bool) -> void:
	is_active = value
	
	if !collider:
		return

	$DamageDetector/CollisionShape2D.disabled = !value
	stateMachine.set_process_unhandled_input(value)
	$EggController.set_process_unhandled_input(value)


func apply_damage() -> void:
	hitPoints.decrease_hitpoints()
	Global.player_hitpoints = hitPoints.hitpoints


func start_flash() -> void:
	flashController.is_active = true


func stop_flash() -> void:
	flashController.is_active = false


