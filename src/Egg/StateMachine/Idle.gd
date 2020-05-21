extends State

onready var move: State = get_parent()


func physics_process(delta: float) -> void:
	move.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	return


func exit() -> void:
	return
