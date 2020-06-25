tool
extends Node

export(float) var travel_duration: = 1.0
export(float) var pause_duration: = 1.0
export(bool) var is_cycled: = false
export(bool) var is_oneshot: = false
export(bool) var is_active: = false

var point_index: int = 0
var target_position: Vector2

onready var points: Array = $TargetPoints.get_children()
onready var tween: Tween = $Tween
onready var pauseTimer: Timer = $PauseTimer
onready var target_node: = get_parent()


func _on_Tween_tween_all_completed() -> void:
	if pause_duration > 0:
		pauseTimer.start()
	else:
		start_movement()


func _on_PauseTimer_timeout() -> void:
	start_movement()


func _ready() -> void:
	
	if pause_duration > 0:
		pauseTimer.wait_time = pause_duration
	
	if is_active:
		start_movement()


func start_movement() -> void:
	calculate_target_position()
	
	if point_index != points.size():
		start_tween()
		point_index += 1


func start_tween() -> void:
	var tween_type: = Tween.TRANS_LINEAR if pause_duration == 0 else Tween.TRANS_QUINT
	tween.interpolate_property(
		target_node,
		"global_position",
		target_node.global_position,
		target_position,
		travel_duration,
		tween_type,
		Tween.EASE_IN_OUT
	)
	tween.start()


func calculate_target_position() -> void:
	if point_index == points.size() and !is_oneshot:
		if !is_cycled:
			points.invert()
		
		point_index = 0 if is_cycled else 1
	
	target_position = points[point_index].global_position
