extends State

export(float) var acceleration_x = 5000.0
export(float) var air_friction_x = 0

onready var move: State = get_parent()
onready var sprite: AnimatedSprite = get_node("../../../Sprite")


func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)


func physics_process(delta: float) -> void:
	move.physics_process(delta)
	
	if owner.is_on_floor():
		var target_state: = "Move/Idle" if move.get_move_direction().x == 0.0 else "Move/Run"
		stateMachine.transition_to(target_state)


func enter(msg: Dictionary = {}) -> void:
#	move.enter(msg)
#	sprite.play("fall")
#	move.friction = Vector2.ZERO
	pass


func exit() -> void:
#	move.exit()
#	move.acceleration.x = move.acceleration_default.x
#	move.friction = move.friction_default
#	move.max_velocity = move.max_velocity_default
#
#	if move.get_move_direction().x == 0:
#		move.velocity.x = 0
	pass


func calculate_jump_velocity(impulse: float = 0.0) -> Vector2:
	return move.calculate_velocity_y(impulse, -1)
