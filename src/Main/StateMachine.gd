extends Node
class_name StateMachine, "res://assets/EngineIcons/icon_stateMachine.svg"

const STATE_NULL: int = -1

var state: int = STATE_NULL
var previous_state: int = STATE_NULL
var states: Dictionary = {}

onready var parent = get_parent()


func _physics_process(delta: float) -> void:
	if state!= STATE_NULL:
		_state_logic()
		var transition: = _get_transition()
		
		if transition != STATE_NULL:
			set_state(transition)


func _state_logic(delta: float = get_physics_process_delta_time()) -> void:
	pass


func _get_transition(delta: float = get_physics_process_delta_time()) -> int:
	return STATE_NULL


func _enter_state(state: int, new_state: int) -> void:
	pass


func _exit_state(state: int, new_state: int) -> void:
	pass


func set_state(new_state: int) -> void:
	previous_state = state
	state = new_state
	
	if previous_state != STATE_NULL:
		_exit_state(previous_state, new_state)
	
	if new_state != STATE_NULL:
		_enter_state(new_state, previous_state)


func add_state(state_name: String) -> void:
	states[state_name] = states.size()
