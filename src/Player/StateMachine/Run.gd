extends State

onready var player: Player = Global.player
onready var move: State = get_parent()
onready var sprite: AnimatedSprite = player.get_node("Sprite")


func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)


func physics_process(delta: float) -> void:
	if player.is_on_floor():
		if move.get_move_direction().x == 0.0:
			stateMachine.transition_to("Move/Idle")
	else:
		stateMachine.transition_to("Move/Fall", { is_coyote_time_active = true })
	move.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	move.enter()
	sprite.play("run")


func exit() -> void:
	move.exit()
