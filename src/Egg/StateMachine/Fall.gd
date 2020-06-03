extends State

onready var move: State = get_parent()
onready var egg: Egg = Global.egg


func physics_process(delta: float) -> void:
	move.physics_process(delta)
	move.apply_bounce()
	
	if abs(move.velocity.x) < 1:
		move.velocity.x = 0
		stateMachine.transition_to("Move/Idle")


func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)


func exit() -> void:
	move.exit()
	move.velocity.y = 0
