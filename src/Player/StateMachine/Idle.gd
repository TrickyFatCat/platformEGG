extends State

onready var player: Player = Global.player
onready var move: State = get_parent()
onready var sprite: AnimatedSprite = player.get_node("Sprite")


func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)


func physics_process(delta: float) -> void:
	move.physics_process(delta)
	if player.is_on_floor() and move.get_move_direction().x != 0.0:
		stateMachine.transition_to("Move/Run")
	elif !player.is_on_floor():
		stateMachine.transition_to("Move/Fall", { is_coyote_time_active = true })


func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	sprite.play("idle")
	
	if is_previous_state("Fall"):
		move.velocity.x *= 0.35


func exit() -> void:
	move.exit()
