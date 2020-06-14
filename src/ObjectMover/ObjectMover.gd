tool
extends Node

export(NodePath) var target_object: = ""
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


func _on_Tween_tween_all_completed() -> void:
	if pause_duration > 0:
		pauseTimer.start()
	else:
		start_movement()


func _on_PauseTimer_timeout() -> void:
	start_movement()
	pass # Replace with function body.


func _ready() -> void:
	pauseTimer.wait_time = pause_duration
	
	if is_active:
		start_movement()


func start_movement() -> void:
	pass


func calculate_target_position() -> void:
	if point_index == points.size() and !is_oneshot:
		if is_cycled:
			points.invert()
		
		point_index = 0 if is_cycled else 1
	
	target_position = points[point_index].global_position


