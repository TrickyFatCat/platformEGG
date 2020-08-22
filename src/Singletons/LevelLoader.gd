extends Node

var next_level: String
var current_level: String
var next_level_id: int
var current_level_id: int = 0
var fruits_gained: int = 0
var levels_data : Array = [
	["res://levels/GameLevels/World01/W01L01.tscn", 0, 10, false, false],
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

	if get_fruits_gained(current_level_id) < fruits_gained:
		set_fruits_gained(current_level_id, fruits_gained)

	if not get_is_level_completed(current_level_id):
		set_is_level_completed(current_level_id, true)
	
	if get_is_level_locked(next_level_id):
		set_is_level_locked(next_level_id, false)

	fruits_gained = 0


func load_level_by_path(path: String) -> void:
	get_tree().change_scene(path)


func load_main_menu() -> void:
	load_level_by_path("res://levels/Menus/MainMenu.tscn")


func set_next_level() -> void:
	next_level_id = current_level_id + 1
	current_level_id = next_level_id
	next_level = get_level_path(next_level_id)


func increase_fruits_gained() -> void:
	fruits_gained += 1


func reset_levels_data() -> void:
	for i in range(levels_data.size()):
		set_fruits_gained(i, 0)
		set_is_level_completed(i, false)
		
		if i != 0:
			set_is_level_locked(i, true)


func get_level_path(level_id: int) -> String:
	return levels_data[level_id][0]


func set_fruits_gained(level_id: int, amount: int) -> void:
	levels_data[level_id][1] = amount


func get_fruits_gained(level_id: int) -> int:
	return levels_data[level_id][1]


func get_fruits_max(level_id: int) -> int:
	return levels_data[level_id][2]


func set_is_level_completed(level_id: int, is_completed: bool) -> void:
	levels_data[level_id][3] = is_completed


func get_is_level_completed(level_id: int) -> bool:
	return levels_data[level_id][3]


func set_is_level_locked(level_id: int, is_locked: bool) -> void:
	levels_data[level_id][4] = is_locked


func get_is_level_locked(level_id: int) -> bool:
	return levels_data[level_id][4]
