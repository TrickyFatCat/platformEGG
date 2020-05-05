extends State

onready var move: State = get_parent()


func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)


func physics_process(delta: float) -> void:
	if owner.is_on_floor() && move.get_move_direction().x != 0.0:
		_state_machine.transition_to("Move/Run")
	elif !owner.is_on_floor():
		_state_machine.transition_to("Move/Air")


func enter(msg: Dictionary = {}) -> void:
	var move: = get_parent()
	move.enter(msg)
	move.max_velocity = move.max_velocity_default
	move.velocity = Vector2.ZERO


func exit() -> void:
	get_parent().exit() 
