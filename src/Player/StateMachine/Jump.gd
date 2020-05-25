extends State

export(float) var acceleration_x = 5000.0
export(float) var air_friction_x = 0

onready var player: Player = Global.player
onready var move: State = get_parent()
onready var sprite: AnimatedSprite = get_node("../../../Sprite")


func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)
	
	if event.is_action_released("jump"):
		move.velocity.y /= 4


func physics_process(delta: float) -> void:
	move.physics_process(delta)
	
	if move.velocity.y >= 0:
		stateMachine.transition_to("Move/Fall")


func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	sprite.play("jump")
	move.acceleration.x = acceleration_x
	
	if "velocity" in msg:
		move.friction = 0
		move.velocity = msg.velocity
		move.velocity_max.x = max(abs(msg.velocity.x), player.velocity_max.x)
		calculate_jump_velocity(msg.velocity.y)
	
	yield(get_tree(), "idle_frame")
	move.gravity = Global.GRAVITY


func exit() -> void:
	move.exit()
	move.acceleration.x = player.acceleration.x
	move.friction = player.ground_friction
	move.velocity_max = player.velocity_max
	
	if move.get_move_direction().x == 0:
		move.velocity.x = 0


func calculate_jump_velocity(impulse: float = 0.0) -> Vector2:
	return move.calculate_velocity_y(impulse, -1)
