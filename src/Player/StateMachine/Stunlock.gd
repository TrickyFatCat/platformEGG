extends State

var acceleration_x: float = 10000.0
var max_velocity_x: float = 150.0
var stunlock_direction: Vector2 = Vector2.UP

onready var move: State = get_parent()
onready var SpriteNode: AnimatedSprite = get_node("../../../Sprite")


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	var direction: = Vector2(stunlock_direction.x, 1)
#	move.velocity = move.calculate_velocity(move.velocity, move.max_velocity, move.acceleration, delta, direction)
	move.velocity = owner.move_and_slide(move.velocity, owner.FLOOR_NORMAL)
	if owner.is_on_ceiling():
		move.velocity.y = 0
	Events.emit_signal("player_moved", owner)
	pass


func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	move.acceleration.x = acceleration_x
	move.max_velocity.x = max_velocity_x
	SpriteNode.play("stunlock")
	
	if "direction" in msg:
		if msg.direction.x != 0:
			stunlock_direction.x = -msg.direction.x
		else:
			stunlock_direction.x = 1.0 if SpriteNode.flip_h else -1.0
	
	if "area_position" in msg:
		if msg.area_position.y > owner.global_position.y:
			if "impulse" in msg:
				if move.velocity.y > 0:
					move.velocity.y = 0
				
				move.velocity += calculate_stunlock_velocity(msg.impulse)


func exit() -> void:
	move.exit()
	move.acceleration.x = move.acceleration_default.x
	move.max_velocity.x = move.max_velocity_default.x


func calculate_stunlock_velocity(impulse: float = 0.0) -> Vector2:
#	return move.calculate_velocity(
#		move.velocity,
#		move.max_velocity,
#		Vector2(0.0, impulse),
#		1.0,
#		stunlock_direction
#	)
	return Vector2.ZERO


func _on_Sprite_animation_finished() -> void:
	if SpriteNode.animation == "stunlock":
		var target_state: = "Move/Idle" if owner.is_on_floor() else "Move/Air"
		_state_machine.transition_to(target_state)
