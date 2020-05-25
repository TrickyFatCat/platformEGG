extends State

onready var player: Player = Global.player
onready var move: State = get_parent()
onready var sprite: AnimatedSprite = get_node("../../../Sprite")


func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)
	
	if event.is_action_released("jump"):
		move.velocity.y /= 10
		if move.velocity.y > -25:
			move.velocity.y = -25
		print(move.velocity.y)


func physics_process(delta: float) -> void:
	move.physics_process(delta)
	
	if move.velocity.y >= 0:
		stateMachine.transition_to("Move/Fall")


func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	sprite.play("jump")
	
	if "velocity" in msg:
		move.friction = 0
		move.velocity = msg.velocity
		move.velocity_max.x = max(abs(msg.velocity.x), player.velocity_max.x)
		calculate_jump_velocity(msg.velocity.y)
	
	yield(get_tree(), "idle_frame")
	move.gravity = Global.GRAVITY


func exit() -> void:
	move.exit()
#	move.friction = player.ground_friction
	move.velocity_max = player.velocity_max


func calculate_jump_velocity(impulse: float = 0.0) -> Vector2:
	return move.calculate_velocity_y(impulse, -1)
