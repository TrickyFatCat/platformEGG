extends State

onready var player: Player = Global.player
onready var move: State = get_parent()
onready var sprite: AnimatedSprite = player.get_node("Sprite")


func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)


func physics_process(delta: float) -> void:
	move.physics_process(delta)
	
	if owner.is_on_floor():
		var target_state: = "Move/Idle" if move.get_move_direction().x == 0.0 else "Move/Run"
		stateMachine.transition_to(target_state)


func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	sprite.play("fall")
	move.friction = 0


func exit() -> void:
	move.exit()
#	move.acceleration.x = move.acceleration_default.x
#	move.velocity.x *= 0.35
	move.friction = player.ground_friction
#	move.max_velocity = move.max_velocity_default
#
#	if move.get_move_direction().x == 0:
#		move.velocity.x = 0
