tool
extends Node2D

export(bool) var is_rotation_endless: = false
export(bool) var is_clockwise: = true
export(float) var fluctuation_duration: = 1.0
export(float) var pause_duration: = 0.25
export(float) var angle_min_default: = 45.0
export(float) var angle_max_default: = -45.0
export(bool) var is_debug_enabled: = false

onready var tween: Tween = $Tween
onready var pauseTimer: Timer = $PauseTimer
onready var rotation_direction: int = 1 if is_clockwise else -1
onready var tween_type = Tween.TRANS_LINEAR if is_rotation_endless else Tween.TRANS_QUINT
onready var angle_min = angle_min_default if !is_rotation_endless else 0
onready var angle_max = angle_max_default if !is_rotation_endless else 360


func _on_Tween_tween_all_completed() -> void:
	if !is_rotation_endless:
		if pause_duration > 0:
			pauseTimer.start()
		else:
			restart_tween()


func _on_PauseTimer_timeout() -> void:
	restart_tween()


func _ready() -> void:
	angle_min *= rotation_direction
	angle_max *= rotation_direction
	rotation_degrees = angle_min
	pauseTimer.wait_time = pause_duration
	tween.repeat = is_rotation_endless
	start_tween(angle_min, angle_max)
	switch_debug_mode()


func _process(delta: float) -> void:
	if is_debug_enabled:
		$MinAngle.rotation_degrees = angle_min - rotation_degrees
		$MaxAngle.rotation_degrees = angle_max - rotation_degrees


func start_tween(initial_angle: float, target_angle: float) -> void:
	tween.interpolate_property(
		self,
		"rotation_degrees",
		initial_angle,
		target_angle,
		fluctuation_duration,
		tween_type,
		Tween.EASE_IN_OUT
	)
	tween.start()


func restart_tween() -> void:
	if rotation_degrees == angle_min:
		start_tween(angle_min, angle_max)
	elif rotation_degrees == angle_max:
		start_tween(angle_max, angle_min)


func switch_debug_mode() -> void:
	$MinAngle.visible = is_debug_enabled
	$MaxAngle.visible = is_debug_enabled
