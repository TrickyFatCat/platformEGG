extends State

onready var move: State = get_parent()
onready var egg: Egg = Global.egg


func physics_process(delta: float) -> void:
	if !egg.is_on_floor():
		move.apply_gravity(delta)
	elif move.velocity.y != 0:
		move.velocity.y = 0
	
	egg.move_and_slide(move.velocity, Global.FLOOR_NORMAL)
	
	if move.velocity.x != 0 and move.velocity.y != 0:
		stateMachine.transition_to("Move/Fall")


func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	print("=== Enter Idle ===")
	print(move.velocity)
#	move.direction_move = Vector2.ZERO


func exit() -> void:
	move.exit()
	print(move.velocity)
	print("=== Exit Idle ===")
