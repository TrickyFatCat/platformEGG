extends Node

const DEFAULT_DAMAGE: int = 1

var player_hitpoints_max: int = 3
var egg_hitpoints_max: int = 3

onready var player_hitpoints: int = player_hitpoints_max
onready var egg_hitpoints: int = egg_hitpoints_max


func _ready() -> void:
	Events.connect("player_took_damage", self, "decrease_player_hitpoints")
	Events.connect("egg_took_damage", self, "decrease_egg_hitpoints")


func reset_hitpoints() -> void:
	player_hitpoints = player_hitpoints_max
	egg_hitpoints = egg_hitpoints_max


func decrease_player_hitpoints() -> void:
	player_hitpoints -= DEFAULT_DAMAGE


func decrease_egg_hitpoints() -> void:
	egg_hitpoints -= DEFAULT_DAMAGE
