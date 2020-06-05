extends Node

signal game_started()
signal game_paused()
signal game_stoped()

const START_TRANSITION_DELAY: float = 1.5

onready var stateMachine: StateMachine = $StateMachine


func _ready() -> void:
	Events.connect("level_loaded", self, "start_transition")
	TransitionScreen.connect("screen_opened", self, "start_session")


func start_transition() -> void:
	yield(get_tree().create_timer(START_TRANSITION_DELAY), "timeout")
	TransitionScreen.start_transition()


func start_session() -> void:
	stateMachine.transition_to("Active")
