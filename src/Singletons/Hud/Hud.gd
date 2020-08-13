extends CanvasLayer

signal pause_menu_opened()
signal pause_menu_closed()

var is_active: bool = false

onready var pauseMenu: Control = $PauseMenu
onready var resourcesPanel: HBoxContainer = $Resources
onready var playerHitpoints: HBoxContainer = $Resources/PlayerHitPoints
onready var eggHitpoints: HBoxContainer = $Resources/EggHitPoints


func _ready() -> void:
	connect("pause_menu_closed", self, "unpause_game")
	Events.connect("player_took_damage", self, "update_player_hitpoints")
	Events.connect("level_loaded", self, "update_player_hitpoints")
	Events.connect("egg_took_damage", self, "update_egg_hitpoints")
	Events.connect("level_loaded", self, "update_egg_hitpoints")
	Events.connect("level_loaded", self, "switch_resources_panel")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and is_active:
		match get_tree().paused:
			true:
				# get_tree().paused = false
				pauseMenu.start_transition()
				resourcesPanel.visible = true
				pass
			false:
				pauseMenu.start_transition()
				get_tree().paused = true
				resourcesPanel.visible = false
				pass


func unpause_game() -> void:
	get_tree().paused = false


func update_player_hitpoints() -> void:
	if Global.player:
		playerHitpoints.set_resource_value(Global.player.hitPoints.hitpoints)


func update_egg_hitpoints() -> void:
	if Global.egg:
		eggHitpoints.set_resource_value(Global.egg.hitPoints.hitpoints)


func switch_resources_panel() -> void:
	resourcesPanel.visible = is_active
	print(is_active)
