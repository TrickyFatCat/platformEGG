extends Node

signal game_started()
signal game_paused()
signal game_stoped()

enum difficulty{
	NORMAL,
	HARD
}

const START_TRANSITION_DELAY: float = 0.5
const START_TIMER_DURATION: float = 0.25
const MUSIC_FADE_DURATION : float = 0.5

var game_difficulty = difficulty.NORMAL

onready var stateMachine: StateMachine = $StateMachine
onready var startTimer: Timer = $StartTimer
onready var finish_track : AudioStream = preload("res://sounds/sfx_goose.wav")
onready var damage_sound : String = "res://sounds/sfx_goose.wav"
onready var take_sound : String = "res://sounds/sfx_goose.wav"
onready var throw_sound : String = "res://sounds/sfx_goose.wav"
onready var fruit_sound : String = "res://sounds/sfx_goose.wav"


func _on_StartTimer_timeout():
	stateMachine.transition_to("Active")
						

func _ready() -> void:
	Events.connect("level_loaded", self, "start_transition")
	Events.connect("player_dead", self, "restart_session")
	TransitionScreen.connect("screen_opened", self, "start_session")
	Events.connect("level_finished", self, "stop_session")
	Events.connect("open_finish_screen", self, "_play_finish_track")
	Events.connect("egg_took_damage", self, "_play_damage_sound")
	Events.connect("player_took_damage", self, "_play_damage_sound")
	Events.connect("player_took_egg", self, "_play_take_sound")
	Events.connect("player_threw_egg", self, "_play_take_sound")
	Events.connect("fruit_earned", self, "_play_fruit_sound")

	startTimer.wait_time = START_TIMER_DURATION


func start_transition() -> void:
	yield(get_tree().create_timer(START_TRANSITION_DELAY), "timeout")
	TransitionScreen.start_transition()


func start_session() -> void:
	stateMachine.transition_to("Starting")


	
func stop_session() -> void:
	stateMachine.transition_to("Inactive")
	start_transition()
	
	if MusicPlayer.playing:
		MusicPlayer.stop_track(MUSIC_FADE_DURATION)


func restart_session() -> void:
	start_transition()


func is_difficulty_normal() -> bool:
	return game_difficulty == difficulty.NORMAL


func is_difficulty_hard() -> bool:
	return game_difficulty == difficulty.HARD


func _play_finish_track() -> void:
	MusicPlayer.play_track(finish_track, 0.0)


func _play_damage_sound() -> void:
	AudioPlayer.play(damage_sound)


func _play_take_sound() -> void:
	AudioPlayer.play(take_sound)


func _play_throw_sound() -> void:
	AudioPlayer.play(throw_sound)


func _play_fruit_sound() -> void:
	AudioPlayer.play(fruit_sound)