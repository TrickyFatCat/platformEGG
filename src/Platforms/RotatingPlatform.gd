extends KinematicBody2D
class_name RotatingPlatform

const ANGLE_ROTATION: = 90.0

export(float) var rotation_duration: = 0.5
export(float) var pause_duration: = 1.0
export(bool) var is_clockwise: = true
export(bool) var is_rotating: = true

var initial_angle: float = 0.0
var target_angle: float = 0.0
var rotation_factor: int = 0

onready var timer: Timer = $Timer
onready var tween: Tween = $Tween

func _ready() -> void:
	if is_clockwise:
		rotation_factor = 1
	else:
		rotation_factor = -1

	timer.wait_time = pause_duration
	timer.connect("timeout", self, "_on_pause_ended")
	tween.connect("tween_all_completed", self, "_on_rotation_completed")
	
	if is_rotating:
		timer.start()


func _on_pause_ended() -> void:
	_start_tween()
	pass


func _on_rotation_completed() -> void:
	timer.start()
	pass


func _start_tween() -> void:
	initial_angle = rotation_degrees
	target_angle = initial_angle + ANGLE_ROTATION

	tween.interpolate_property(
		self,
		"rotation_degrees",
		initial_angle,
		target_angle,
		rotation_duration,
		Tween.TRANS_BACK,
		Tween.EASE_IN_OUT
	)

	tween.start()
