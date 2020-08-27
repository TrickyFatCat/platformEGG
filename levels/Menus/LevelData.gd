extends CanvasLayer

onready var dataPanel : VBoxContainer = $LevelDataContainer
onready var levelNumber : Label = $LevelDataContainer/LevelNumber
onready var fruitsCount : HBoxContainer = $LevelDataContainer/DataPanel/FruitsCount
onready var levelTime : Label = $LevelDataContainer/DataPanel/LevelTime


func _ready() -> void:
	hide_level_data()
	Events.connect("show_level_data", self, "show_level_data")
	Events.connect("hide_level_data", self, "hide_level_data")


func show_level_data(level_id: int) -> void:
	levelNumber.text = "Level %02d" % (level_id + 1)
	fruitsCount.set_resource_value(LevelLoader.get_fruits_gained(level_id), LevelLoader.get_fruits_max(level_id))
	levelTime.text = LevelLoader.get_converted_time(LevelLoader.get_level_time(level_id))
	dataPanel.visible = true


func hide_level_data() -> void:
	dataPanel.visible = false
