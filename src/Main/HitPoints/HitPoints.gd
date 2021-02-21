extends Node
class_name HitPoints

signal damage_taken()
signal hitpoints_zero()
signal invulnerability_lifted()

const DEFAULT_DAMAGE: int = 1

export(int) var hitpoints_max: = 3
export(float) var invulnerability_duration: = 2.0

var is_invulnerable: bool = false setget set_is_invulnerable, get_is_invulnerable

onready var hitpoints: int = hitpoints_max
onready var timer: Timer = $Timer


func _on_Timer_timeout() -> void:
	self.is_invulnerable = false
	emit_signal("invulnerability_lifted")


func _ready() -> void:
	timer.wait_time = invulnerability_duration


func decrease_hitpoints(damage: int = DEFAULT_DAMAGE) -> void:
	if !is_invulnerable:
		hitpoints -= damage
# warning-ignore:narrowing_conversion
		hitpoints = max(hitpoints, 0)
		
		if hitpoints > 0:
			self.is_invulnerable = true
			emit_signal("damage_taken")
		else:
			emit_signal("hitpoints_zero")


func set_is_invulnerable(value: bool) -> void:
	is_invulnerable = value
	
	if value:
		timer.start()


func get_is_invulnerable() -> bool:
	return is_invulnerable