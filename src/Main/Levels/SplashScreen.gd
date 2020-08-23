extends Level

const SPLASH_DURATION: float = 0.5

onready var splashTimer: Timer = $SplashTimer


func _on_SplashTimer_timeout() -> void:
	TransitionScreen.start_transition()


func _ready() -> void:
	splashTimer.wait_time = SPLASH_DURATION
	GameManager.connect("game_started", splashTimer, "start")
	LevelLoader.load_main_menu()


