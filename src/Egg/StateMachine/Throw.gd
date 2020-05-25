extends State

onready var move: State = get_parent()
onready var egg: Egg = Global.egg


func physics_process(delta: float) -> void:
	move.physics_process(delta)
	
	if move.velocity.x == 0:
		stateMachine.transition_to("Move/Idle")


func enter(msg: Dictionary = {}) -> void:
	move.gravity = 0
	
	if "throw_velocity" in msg:
		move.velocity = msg.throw_velocity
	
	yield(get_tree(), "idle_frame")
	move.gravity = Global.GRAVITY


func exit() -> void:
	move.exit()
