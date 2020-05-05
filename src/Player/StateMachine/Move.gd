extends State

export(Vector2) var max_velocity_default = Vector2(500.0, 1500.0)
export(Vector2) var acceleration_default = Vector2(10000.0, 3000.0)
export(float) var jump_impulse = 900.0

var acceleration: Vector2 = acceleration_default
var max_velocity: Vector2 = max_velocity_default
var velocity: Vector2 = Vector2.ZERO


func unhandled_input(event: InputEvent) -> void:
	if owner.is_on_floor() && event.is_action_pressed("jump"):
		_state_machine.transition_to("Move/Air", { impulse = jump_impulse })


func physics_process(delta: float) -> void:
	velocity = calculate_velocity(velocity, max_velocity, acceleration, delta, get_move_direction())
	velocity = owner.move_and_slide(velocity, owner.FLOOR_NORMAL)
	Events.emit_signal("player_moved", owner)


static func calculate_velocity(
		old_velocity: Vector2,
		max_velocity: Vector2,
		acceleration: Vector2,
		delta: float,
		move_direction: Vector2
	)-> Vector2:
	var new_velocity = old_velocity
	new_velocity += move_direction * acceleration * delta
	new_velocity.x = clamp(new_velocity.x, -max_velocity.x, max_velocity.x)
	new_velocity.y = clamp(new_velocity.y, -max_velocity.y, max_velocity.y)
	return new_velocity


static func get_move_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		1.0
	)
