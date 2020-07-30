tool
extends PlayerTrigger

enum difficulty{
	NORMAL,
	HARD
}

export(difficulty) var game_difficulty = difficulty.NORMAL
export(String, FILE, "*.tscn") var level

onready var levelNumber: Label = $LevelNumber


func _ready() -> void:
	levelNumber.text = name.right(name.length() - 2)


func _on_trigger_activated() -> void:
	if level:
		LevelLoader.next_level = level

	GameManager.stop_session()
	GameManager.game_difficulty = game_difficulty
