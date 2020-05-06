extends State

export(float) var acceleration_x = 5000.0

onready var move: State = get_parent()
onready var SpriteNode: AnimatedSprite = get_node("../../../Sprite")


func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)


func physics_process(delta: float) -> void:
	move.physics_process(delta)
	
	if move.velocity.y < 0:
		SpriteNode.play("jump")
	elif move.velocity.y > 0:
		SpriteNode.play("fall")
	
	if owner.is_on_floor():
		var target_state: = "Move/Idle" if move.get_move_direction().x == 0.0 else "Move/Run"
		_state_machine.transition_to(target_state)


func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	move.acceleration.x = acceleration_x
	
	if "velocity" in msg:
		move.velocity = msg.velocity
		move.max_velocity.x = max(abs(msg.velocity.x), move.max_velocity_default.x)
	
	if "impulse" in msg:
		move.velocity += calculate_jump_velocity(msg.impulse)


func exit() -> void:
	move.exit()
	move.acceleration.x = move.acceleration_default.x


func calculate_jump_velocity(impulse: float = 0.0) -> Vector2:
	return move.calculate_velocity(
		move.velocity,
		move.max_velocity,
		Vector2(0.0, impulse),
		1.0,
		Vector2.UP
	)
