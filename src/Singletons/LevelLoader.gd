extends Node

var next_level: String
var current_level: String
var next_level_id: int
var current_level_id: int = 0
var levels: PoolStringArray = [
	"res://levels/GameLevels/World01/W01L01.tscn",
	"res://levels/GameLevels/World01/W01L02.tscn",
	"res://levels/GameLevels/World01/W01L03.tscn",
	"res://levels/GameLevels/World01/W01L04.tscn",
	"res://levels/GameLevels/World01/W01L05.tscn",
	"res://levels/GameLevels/World01/W01L06.tscn",
	"res://levels/GameLevels/World01/W01L07.tscn",
	"res://levels/GameLevels/World01/W01L08.tscn",
	"res://levels/GameLevels/World01/W01L09.tscn",
	"res://levels/GameLevels/World01/W01L10.tscn",
	"res://levels/GameLevels/World01/W01L11.tscn",
	"res://levels/GameLevels/World01/W01L12.tscn",
	"res://levels/GameLevels/World01/W01L13.tscn",
	"res://levels/GameLevels/World01/W01L14.tscn",
	"res://levels/GameLevels/World01/W01L15.tscn",
	"res://levels/GameLevels/World01/W01L16.tscn",
	"res://levels/GameLevels/World01/W01L17.tscn",
	"res://levels/GameLevels/World01/W01L18.tscn",
	"res://levels/GameLevels/World01/W01L19.tscn",
	"res://levels/GameLevels/World01/W01L20.tscn",
	"res://levels/GameLevels/World01/W01L21.tscn",
	"res://levels/GameLevels/World01/W01L22.tscn",
	"res://levels/GameLevels/World01/W01L23.tscn",
	"res://levels/GameLevels/World01/W01L24.tscn",
	"res://levels/GameLevels/World01/W01L25.tscn",
	"res://levels/GameLevels/World01/W01L26.tscn",
	"res://levels/GameLevels/World01/W01L27.tscn",
	"res://levels/GameLevels/World01/W01L28.tscn",
	"res://levels/GameLevels/World01/W01L29.tscn",
	"res://levels/GameLevels/World01/W01L30.tscn",
	"res://levels/GameLevels/World01/W01L31.tscn",
	"res://levels/GameLevels/World01/W01L32.tscn"
]

onready var first_level: String = levels[0]


func _ready() -> void:
	TransitionScreen.connect("screen_closed", self, "load_level")


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


func load_level_by_path(path: String) -> void:
	get_tree().change_scene(path)
