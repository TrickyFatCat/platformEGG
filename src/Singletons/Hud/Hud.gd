extends CanvasLayer

signal pause_menu_opened()
signal pause_menu_closed()
signal finish_screen_opened( )
signal finish_screen_closed()

var is_active: bool = false

onready var pauseMenu : Control = $PauseMenu
onready var dataPanel : HBoxContainer = $DataPanel
onready var playerHitpoints : HBoxContainer = $DataPanel/Resources/PlayerHitPoints
onready var eggHitpoints : HBoxContainer = $DataPanel/Resources/EggHitPoints
onready var fruitsCount : HBoxContainer = $DataPanel/Resources/FruitsCount
onready var levelTimer : Label = $DataPanel/LevelTimer
onready var finishScreen : Control = $FinishScreen


func _ready() -> void:
	connect("pause_menu_closed", self, "unpause_game")
	Events.connect("player_took_damage", self, "update_player_hitpoints")
	Events.connect("level_loaded", self, "update_player_hitpoints")
	Events.connect("egg_took_damage", self, "update_egg_hitpoints")
	Events.connect("level_loaded", self, "update_egg_hitpoints")
	Events.connect("level_loaded", self, "switch_data_panel")
	Events.connect("fruit_earned", self, "update_fruits_count")
	Events.connect("level_loaded", self, "update_fruits_count")
	TransitionScreen.connect("screen_closed", self, "force_unpause")
	Events.connect("open_finish_screen", self, "open_finish_screen")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and is_active:
		process_ui_cancel()
	
	if event.is_action_pressed("ui_select") and is_active:
		process_ui_select()


func _notification(what: int) -> void:
	if what == MainLoop.NOTIFICATION_WM_FOCUS_OUT and is_active and not finishScreen.is_active:
		pauseMenu.start_transition()
		get_tree().paused = true


func _process(delta: float) -> void:
	levelTimer.text = LevelLoader.get_converted_time(LevelLoader.level_time)


func unpause_game() -> void:
	get_tree().paused = false


func update_player_hitpoints() -> void:
	if Global.player:
		playerHitpoints.set_resource_value(Global.player.hitPoints.hitpoints)


func update_egg_hitpoints() -> void:
	if Global.egg:
		eggHitpoints.set_resource_value(Global.egg.hitPoints.hitpoints)


func update_fruits_count() -> void:
	fruitsCount.set_resource_value(LevelLoader.fruits_gained)


func switch_data_panel() -> void:
	dataPanel.visible = is_active


func force_unpause() -> void:
	if get_tree().paused:
		pauseMenu.force_closing()


func open_finish_screen() -> void:
	finishScreen.start_transition()
	dataPanel.visible = false


func process_ui_cancel() -> void:
	if finishScreen.is_active:
		LevelLoader.load_main_menu()
		return

	match get_tree().paused:
		true:
			pauseMenu.start_transition()
			dataPanel.visible = true
			pass
		false:
			pauseMenu.start_transition()
			get_tree().paused = true
			dataPanel.visible = false
			pass


func process_ui_select() -> void:
	if finishScreen.is_active:
		Events.emit_signal("level_finished")
		return

	if get_tree().paused:
		LevelLoader.load_main_menu()
		GameManager.stop_session()
