extends HBoxContainer

var fruits_max : int = 0
var fruits_current : int = 0

onready var fruitsValue : Label = $Value


func _ready() -> void:
    Events.connect("level_loaded", self, "update_fruits_max")


func set_resource_value(value: int, value_max: int = -1) -> void:
    fruits_current = value

    if value_max != -1:
        fruits_max = value_max

    fruitsValue.text = "%03d/%03d" % [fruits_current, fruits_max]


func update_fruits_max() -> void:
    if LevelLoader.current_level_id != -1:
        fruits_max = LevelLoader.get_fruits_max(LevelLoader.current_level_id)