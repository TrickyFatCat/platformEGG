extends State

onready var move: State = get_parent()
onready var egg: Egg = Global.egg


func physics_process(delta: float) -> void:
	move.apply_gravity(delta)
	egg.move_and_slide(move.velocity, Global.FLOOR_NORMAL)
	
	if move.velocity.x != 0 and move.velocity.y != 0:
		stateMachine.transition_to("Move/Throw")


func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)


func exit() -> void:
	move.exit()
