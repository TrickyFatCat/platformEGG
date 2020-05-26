extends State

var max_velocity_x: float = 125.0
var stunlock_direction: Vector2 = Vector2.UP

onready var move: State = get_parent()
onready var sprite: AnimatedSprite = get_node("../../../Sprite")


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	var direction: = Vector2(stunlock_direction.x, 1)
	move.calculate_velocity_x(delta, direction)
	move.apply_gravity(delta)
	move.velocity = owner.move_and_slide(move.velocity, Global.FLOOR_NORMAL)
	
	if owner.is_on_ceiling():
		move.velocity.y = 0
	
	Events.emit_signal("player_moved", owner)
	
	if sprite.frame == sprite.frames.get_frame_count(sprite.animation) - 1:
		var target_state: = "Move/Idle" if owner.is_on_floor() else "Move/Fall"
		stateMachine.transition_to(target_state)


func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	sprite.play("stunlock")
	sprite.frame = 0
	move.max_velocity.x = max_velocity_x
	move.gravity = 0
	
	if "area_position" in msg:
		if move.velocity.y != 0:
			move.velocity.y = 0
		
		if msg.area_position.y >= owner.global_position.y:
			stunlock_direction.x = 1.0 if sprite.flip_h else -1.0
			if "impulse" in msg:
				move.calculate_velocity_y(msg.impulse, stunlock_direction.y)
		else:
			stunlock_direction.x = (owner.global_position - msg.area_position).normalized().x
	
	move.velocity.x = stunlock_direction.x * max_velocity_x
	Events.emit_signal("player_stunlock_entered")
	yield(get_tree(), "idle_frame")
	move.gravity = Global.GRAVITY

func exit() -> void:
	move.exit()
	move.acceleration.x = move.acceleration_default.x
	move.max_velocity.x = move.max_velocity_default.x
	move.friction.x = move.friction_default.x
	Events.emit_signal("player_stunlock_exited")
