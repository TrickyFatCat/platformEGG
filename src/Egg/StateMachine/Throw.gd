extends State

onready var move: State = get_parent()
onready var egg: Egg = Global.egg


func physics_process(delta: float) -> void:
	move.physics_process(delta)
	move.apply_bounce()
	
	if move.velocity.x == 0:
		stateMachine.transition_to("Move/Idle")


func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	move.gravity = 0
	print("Hello")
	
	if "velocity" and "direction" in msg:
		move.calculate_throw_velocity(msg.velocity, msg.direction)
		print(move.velocity)
		
	yield(get_tree(), "idle_frame")
	move.gravity = Global.GRAVITY


func exit() -> void:
	move.exit()
