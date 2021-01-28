tool
extends Node

export(float) var travel_duration: = 1.0
export(float) var waiting_duration: = 1.0
export(bool) var is_cycled: = false
export(bool) var is_active: = false

var point_index: int = 0
var target_position: Vector2
var current_position: Vector2 = Vector2.ZERO

onready var points: Array = $TargetPoints.get_children()
onready var tween: Tween = $MovementTween
onready var waitingTimer: Timer = $WaitingTimer
onready var target_node: = get_parent()


func _on_Tween_tween_all_completed() -> void:
	if waiting_duration > 0:
		waitingTimer.start()
	else:
		start_movement()


func _on_PauseTimer_timeout() -> void:
	start_movement()


func _ready() -> void:
	tween.connect("tween_all_completed", self, "_on_Tween_tween_all_completed")
	waitingTimer.connect("timeout", self, "_on_PauseTimer_timeout")

	if waiting_duration > 0:
		waitingTimer.wait_time = waiting_duration
	
	if is_active:
		current_position = points[0].global_position
		target_node.global_position = current_position
		start_movement()


func start_movement() -> void:
	calculate_target_position()
	
	if point_index != points.size():
		start_tween()
		point_index += 1


func start_tween() -> void:
	var tween_type: = Tween.TRANS_LINEAR if waiting_duration == 0 else Tween.TRANS_QUINT
	tween.interpolate_property(
		target_node,
		"global_position",
		current_position,
		target_position,
		travel_duration,
		tween_type,
		Tween.EASE_IN_OUT
	)
	tween.start()


func calculate_target_position() -> void:
	if point_index == points.size():
		if !is_cycled:
			points.invert()
		
		point_index = 0 if is_cycled else 1
	
	target_position = points[point_index].global_position
	current_position = target_node.global_position
