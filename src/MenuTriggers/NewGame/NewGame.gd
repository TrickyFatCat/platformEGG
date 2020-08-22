tool
extends PlayerTrigger

enum difficulty{
	NORMAL,
	HARD
}

export(difficulty) var game_difficulty = difficulty.NORMAL
export(int, 0, 31) var level_id := 0


onready var levelNumber: Label = $LevelNumber
onready var fruitsCount: Label = $FruitsCount


func _ready() -> void:
	levelNumber.text = String("%02d" % (level_id + 1))

	if not Engine.editor_hint:
		_set_fruits_count()
		is_active = not LevelLoader.get_is_level_locked(level_id)

		if is_active:
			$DeleteME.color = Color8(133, 255, 0, 50)

			if not LevelLoader.get_is_level_completed(level_id):
				$DeleteME.color = Color8(255, 209, 0, 150)
		else:
			$DeleteME.color = Color8(255, 0, 72, 145)


func _on_trigger_activated() -> void:
	if not Engine.editor_hint:
		LevelLoader.next_level = LevelLoader.get_level_path(level_id)
		GameManager.stop_session()
		GameManager.game_difficulty = game_difficulty


func _set_fruits_count() -> void:
	var fruits_gained := String("%03d" % LevelLoader.get_fruits_gained(level_id))
	var fruits_max := String("%03d" % LevelLoader.get_fruits_max(level_id))
	fruitsCount.text = fruits_gained + "/" + fruits_max
