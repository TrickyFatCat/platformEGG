extends State

onready var move: State = get_parent()
onready var sprite: AnimatedSprite = get_node("../../../Sprite")

func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)


func physics_process(delta: float) -> void:
	if owner.is_on_floor():
		if move.get_move_direction().x == 0.0:
			stateMachine.transition_to("Move/Idle")
	else:
		stateMachine.transition_to("Move/Air")
	move.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	sprite.play("run")
	move.enter()


func exit() -> void:
	move.exit()
