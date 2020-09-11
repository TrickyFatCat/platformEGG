extends Control

const MIN_ALPHA: float = 0.0
const MAX_ALPHA: float = 0.6
const TRANSITION_DURATION: float = 0.10

var target_state : String = ""
var is_active : bool = false

onready var stateMachine : StateMachine = $StateMachine
onready var transitionTween : Tween = $TransitionTween
onready var background : ColorRect = $Background
onready var state_opened : String = get_node("StateMachine/Opened").name
onready var state_closed : String = get_node("StateMachine/Closed").name
onready var state_transition : String = get_node("StateMachine/Transition").name
onready var finishData : VBoxContainer = $FinishData
onready var finishLabel : Label = $FinishData/FinishLabel
onready var fruitsCount : HBoxContainer = $FinishData/Statistics/FruitsCount
onready var lelvelTime : Label = $FinishData/Statistics/LevelTime


func _on_TransitionTween_tween_all_completed() -> void:
	stateMachine.transition_to(target_state)


func _ready() -> void:
	stateMachine.set_physics_process(false)
	Hud.connect("finish_screen_opened", self, "_show_menu")
	TransitionScreen.connect("screen_closed", self, "force_closing")


func start_transition() -> void:
	if !stateMachine.is_current_state(state_transition):
		target_state = state_opened if stateMachine.is_current_state(state_closed) else state_closed
		#Tween activation
		match target_state:
			state_opened:
				activate_tween(MIN_ALPHA, MAX_ALPHA)
			state_closed:
				activate_tween(MAX_ALPHA, MIN_ALPHA)
		
		stateMachine.transition_to(state_transition)


func set_alpha(value: float) -> void:
	value = clamp(value, MIN_ALPHA, MAX_ALPHA)
	background.color.a = value


func activate_tween(initial_value: float, target_value: float) -> void:
# warning-ignore:return_value_discarded
	transitionTween.interpolate_method(
		self,
		"set_alpha",
		initial_value,
		target_value,
		TRANSITION_DURATION,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
# warning-ignore:return_value_discarded
	transitionTween.start()


func _show_menu() -> void:
	finishData.visible = true
	is_active = true
	finishLabel.text = "LEVEL %02d COMPLETE" % (LevelLoader.current_level_id)
	lelvelTime.text = LevelLoader.get_converted_time(LevelLoader.level_time)
	fruitsCount.set_resource_value(LevelLoader.fruits_gained)


func _hide_menu() -> void:
	finishData.visible = false
	is_active = false


func force_closing() -> void:
	if is_active:
		stateMachine.transition_to(state_closed)
		set_alpha(0)
		_hide_menu()