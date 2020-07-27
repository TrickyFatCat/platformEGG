extends Camera2D

var grid_position: Vector2 = Vector2.ZERO

onready var cameraShaker : Node = $CameraShaker
onready var grid_size: Vector2 = get_viewport().get_visible_rect().size
	
	
func _ready() -> void:
	# warning-ignore:return_value_discarded
	Events.connect("player_took_damage", self, "activate_player_shake")
	# warning-ignore:return_value_discarded
	Events.connect("egg_took_damage", self, "activate_egg_shake")

	if Global.player:
		update_grid_position()
		set_physics_process(true)
	else:
		set_physics_process(false)
		
		

func _physics_process(delta: float) -> void:
	update_grid_position()


func activate_player_shake() -> void:
	cameraShaker.start(0.2, 50, 1)


func activate_egg_shake() -> void:
	cameraShaker.start(0.2, 50, 2, 1)


func update_grid_position() -> void:
	var x: = floor(Global.player.position.x / grid_size.x)
	var y: = floor(Global.player.position.y / grid_size.y)
	var new_grid_position: = Vector2(x, y)
	
	if grid_position == new_grid_position:
		return

	grid_position = new_grid_position
	position = grid_position * grid_size
