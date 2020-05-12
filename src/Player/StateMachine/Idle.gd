extends State

onready var move: State = get_parent()
onready var SpriteNode: AnimatedSprite = get_node("../../../Sprite")


func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)


func physics_process(delta: float) -> void:
	if owner.is_on_floor() && move.get_move_direction().x != 0.0:
		_state_machine.transition_to("Move/Run")
	elif !owner.is_on_floor():
		_state_machine.transition_to("Move/Air")
	move.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	var move: = get_parent()
	SpriteNode.play("idle")
	move.enter(msg)
	move.max_velocity = move.max_velocity_default


func exit() -> void:
	get_parent().exit()
