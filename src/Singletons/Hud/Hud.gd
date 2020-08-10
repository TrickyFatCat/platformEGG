extends CanvasLayer

signal pause_menu_opened()
signal pause_menu_closed()

var is_active: bool = false

onready var pauseMenu: Control = $PauseMenu
onready var playerHitpoints: HBoxContainer = $Resorces/PlayerHitPoints
onready var egghitpoints: HBoxContainer = $Resources/EggHitPoints


func _ready() -> void:
	connect("pause_menu_closed", self, "unpause_game")
	Events.connect("player_took_damage", self, "update_player_hitpoints")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and is_active:
		match get_tree().paused:
			true:
				# get_tree().paused = false
				pauseMenu.start_transition()
				pass
			false:
				pauseMenu.start_transition()
				get_tree().paused = true
				pass


func unpause_game() -> void:
	get_tree().paused = false


func update_player_hitpoints() -> void:
	playerHitpoints.set_resource_value(Global.player.hitPoints)
