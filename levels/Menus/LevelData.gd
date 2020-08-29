extends CanvasLayer

onready var dataPanel : VBoxContainer = $LevelDataContainer
onready var levelNumber : Label = $LevelDataContainer/LevelNumber
onready var fruitsCount : HBoxContainer = $LevelDataContainer/DataPanel/FruitsCount
onready var levelTime : Label = $LevelDataContainer/DataPanel/LevelTime


func _ready() -> void:
	hide_level_data()
	Events.connect("show_level_data", self, "show_level_data")
	Events.connect("hide_level_data", self, "hide_level_data")


func show_level_data(level_id: int, difficulty) -> void:
	print_debug(difficulty)
	levelNumber.text = "LEVEL %02d" % (level_id + 1) if difficulty == 0 else set_levels_cleared()
	set_fruits_count(level_id, difficulty)
	levelTime.text = LevelLoader.get_converted_time(LevelLoader.get_level_time(level_id))
	dataPanel.visible = true


func hide_level_data() -> void:
	dataPanel.visible = false


func set_levels_cleared() -> String:
	var level_completed = 0
	var level_max = LevelLoader.levels_data.size()

	for level_id in LevelLoader.levels_data.size():
		if LevelLoader.get_is_level_completed_hard(level_id):
			level_completed += 1

	return "%02d/%02d CLEARED" % [level_completed, level_max]


func set_fruits_count(level_id: int, difficulty: int) -> void:
	var fruits_gained = 0
	var fruits_max = 0

	match difficulty:
		0:
			fruits_gained = LevelLoader.get_fruits_gained(level_id)
			fruits_max = LevelLoader.get_fruits_max(level_id)
			pass
		1:
			for i in LevelLoader.levels_data.size():
				fruits_gained += LevelLoader.get_fruits_gained_hard(i)
				fruits_max += LevelLoader.get_fruits_max(i)
			pass

	fruitsCount.set_resource_value(fruits_gained, fruits_max)
