extends State

var stunlock_direction: Vector2 = Vector2.UP

onready var player: Player = Global.player
onready var move: State = get_parent()
onready var sprite: AnimatedSprite = player.get_node("Sprite")


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	move.calculate_velocity_x(delta, stunlock_direction)
	move.apply_gravity(delta)
	move.velocity = player.move_and_slide(move.velocity, Global.FLOOR_NORMAL)
	
	if player.is_on_ceiling():
		move.velocity.y = 0


func enter(msg: Dictionary = {}) -> void:
	Events.emit_signal("player_stunlock_entered")
	move.enter(msg)
	sprite.play("stunlock")
	sprite.frame = 0
	move.gravity = 0
	move.velocity_max.x = player.velocity_stunlock.x
	
	if "hazard_position" and "velocity" and "direction" in msg:
		var player_position: = player.global_position
		var hazard_position = msg.hazard_position
		var is_hazard_beneath: bool = hazard_position.y < player_position.y
		
		if is_hazard_beneath:
			var direction_to_hazard = (player.position - hazard_position).normalized()
			stunlock_direction.x = sign(direction_to_hazard.x)
		else:
			stunlock_direction.x = 1.0 if sprite.flip_h else -1.0
		
		move.calculate_jump_velocity(msg.velocity, stunlock_direction)
		
		if is_hazard_beneath:
			move.velocity.y = 0
	
	yield(get_tree(), "idle_frame")
	move.gravity = Global.GRAVITY


func exit() -> void:
	Events.emit_signal("player_stunlock_exited")
	move.exit()
	move.acceleration.x = player.acceleration.x
	move.velocity_max = player.velocity_max
	move.friction = player.ground_friction
