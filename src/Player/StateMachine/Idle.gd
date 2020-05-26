extends State

onready var player: Player = Global.player
onready var move: State = get_parent()
onready var sprite: AnimatedSprite = get_node("../../../Sprite")


func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)


func physics_process(delta: float) -> void:
	move.physics_process(delta)
	if player.is_on_floor() and move.get_move_direction().x != 0.0:
		stateMachine.transition_to("Move/Run")
	elif !player.is_on_floor():
		stateMachine.transition_to("Move/Fall")


func enter(msg: Dictionary = {}) -> void:
	sprite.play("idle")
	if stateMachine.previous_state.name == "Fall":
		move.velocity.x *= 0.35
#	move.enter(msg)
#	move.max_velocity = move.max_velocity_default
	pass


func exit() -> void:
	pass
#	get_parent().exit()
