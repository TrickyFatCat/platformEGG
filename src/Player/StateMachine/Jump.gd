extends State

const INTERRUPT_FACTOR: float = 0.25

var velocity_x: float = 0.0

onready var player: Player = Global.player
onready var move: State = get_parent()
onready var sprite: AnimatedSprite = player.get_node("Sprite")


func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)
	
	if move.get_move_direction().x != 0:
		move.velocity.x = velocity_x * move.get_move_direction().x
	
	if event.is_action_released("jump"):
		move.velocity.y *= INTERRUPT_FACTOR


func physics_process(delta: float) -> void:
	move.physics_process(delta)
	
	if move.velocity.y >= 0:
		stateMachine.transition_to("Move/Fall")


func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	move.gravity = 0.0
	sprite.play("jump")
	
	if "velocity" and "direction" in msg:
		velocity_x = msg.velocity.x
		move.friction = 0
		move.velocity_max.x = max(abs(msg.velocity.x), player.velocity_max.x)
		move.calculate_jump_velocity(msg.velocity, msg.direction)
	
	yield(get_tree(), "idle_frame")
	move.gravity = Global.GRAVITY


func exit() -> void:
	move.exit()
