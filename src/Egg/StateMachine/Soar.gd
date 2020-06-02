extends State

onready var move: State = get_parent()
onready var egg: Egg = Global.egg


func physics_process(delta: float) -> void:
	move.physics_process(delta)
	move.apply_bounce()
	
	if move.velocity.y > 0:
		stateMachine.transition_to("Move/Fall")
	
	if move.gravity == 0:
		move.gravity = Global.GRAVITY


func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	move.gravity = 0
	
	if "velocity" and "direction" in msg:
		move.velocity = msg.velocity * msg.direction

	yield(get_tree(), "idle_frame")
	move.gravity = Global.GRAVITY


func exit() -> void:
	move.exit()
