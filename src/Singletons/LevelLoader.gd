extends Node

var next_level: String
var current_level: String
var next_level_id: int
var current_level_id: int = 0
var fruits_gained: int = 0
var levels_data: Array = [
	["res://levels/GameLevels/World01/W01L01.tscn", 0, 10, true, false],
	["res://levels/GameLevels/World01/W01L02.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L03.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L04.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L05.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L06.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L07.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L08.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L09.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L10.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L11.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L12.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L13.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L14.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L15.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L16.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L17.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L18.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L19.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L20.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L21.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L22.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L23.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L24.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L25.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L26.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L27.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L28.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L29.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L30.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L31.tscn", 0, 10, false, true],
	["res://levels/GameLevels/World01/W01L32.tscn", 0, 10, false, true],
]

onready var first_level: String = levels_data[0][0]


func _ready() -> void:
	TransitionScreen.connect("screen_closed", self, "load_level")
	Events.connect("fruit_earned", self, "increase_fruits_gained")


func load_level() -> void:
	if next_level != current_level:
		load_next_level()
	else:
		reload_current_level()


func reload_current_level() -> void:
	get_tree().reload_current_scene()


func load_next_level() -> void:
	if next_level:
		load_level_by_path(next_level)
	else:
		push_error("Next level must be defined")

	levels_data[current_level_id][1] = fruits_gained
	fruits_gained = 0


func load_level_by_path(path: String) -> void:
	get_tree().change_scene(path)


func set_next_level() -> void:
	next_level_id = current_level_id + 1
	current_level_id = next_level_id
	next_level = levels_data[next_level_id][0]


func increase_fruits_gained() -> void:
	fruits_gained += 1