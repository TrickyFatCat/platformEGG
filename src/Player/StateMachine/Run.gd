extends State

const MOVE_SOUND_DELAY : float = 0.2

var step_sound : String = "res://sounds/sfx_goose.wav"

onready var player: Player = Global.player
onready var move: State = get_parent()
onready var sprite: AnimatedSprite = player.get_node("Sprite")
onready var move_timer: Timer = $MoveTimer

func _ready() -> void:
	move_timer.wait_time = MOVE_SOUND_DELAY

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
	_play_step_sound()
	move_timer.connect("timeout", self, "_play_step_sound")

func exit() -> void:
	move.exit()
	move_timer.disconnect("timeout", self, "_play_step_sound")



func _play_step_sound() -> void:
	AudioPlayer.play(step_sound)
	move_timer.start()
	pass