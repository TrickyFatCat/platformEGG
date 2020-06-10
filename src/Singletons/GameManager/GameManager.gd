extends Node

signal game_started()
signal game_paused()
signal game_stoped()

const START_TRANSITION_DELAY: float = 0.5
const START_TIMER_DURATION: float = 0.25

onready var stateMachine: StateMachine = $StateMachine
onready var startTimer: Timer = $StartTimer


func _on_StartTimer_timeout():
	stateMachine.transition_to("Active")


func _ready() -> void:
	Events.connect("level_loaded", self, "start_transition")
	Events.connect("player_dead", self, "restart_session")
	TransitionScreen.connect("screen_opened", self, "start_session")
	startTimer.wait_time = START_TIMER_DURATION


func start_transition() -> void:
	yield(get_tree().create_timer(START_TRANSITION_DELAY), "timeout")
	TransitionScreen.start_transition()


func start_session() -> void:
	stateMachine.transition_to("Starting")


func stop_session() -> void:
	stateMachine.transition_to("Inactive")
	start_transition()


func restart_session() -> void:
	LevelLoader.next_level = LevelLoader.current_level
	start_transition()
