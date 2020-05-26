extends State

const COYOTE_TIME_DURATION: float = 0.25

var is_coyote_time_active: bool = false

onready var player: Player = Global.player
onready var move: State = get_parent()
onready var sprite: AnimatedSprite = player.get_node("Sprite")
onready var coyoteTimer: Timer = $CoyoteTimer


func _on_CoyoteTimer_timeout():
	if is_coyote_time_active:
		is_coyote_time_active = false
		print("Coyote is over")


func _ready() -> void:
	coyoteTimer.wait_time = COYOTE_TIME_DURATION


func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)

	if is_coyote_time_active and event.is_action_pressed("jump") and !player.is_with_egg:
		move.apply_jump()


func physics_process(delta: float) -> void:
	move.physics_process(delta)
	
	if player.is_on_floor():
		var target_state: = "Move/Idle" if move.get_move_direction().x == 0.0 else "Move/Run"
		stateMachine.transition_to(target_state)


func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	sprite.play("fall")
	
	if "is_coyote_time_active" in msg:
		is_coyote_time_active = msg.is_coyote_time_active
		move.velocity.y = 0
		coyoteTimer.start()


func exit() -> void:
	move.exit()
	is_coyote_time_active = false
#	move.acceleration.x = move.acceleration_default.x
	move.velocity.x *= 0.35
	move.friction = player.ground_friction
#	move.max_velocity = move.max_velocity_default
#
#	if move.get_move_direction().x == 0:
#		move.velocity.x = 0

