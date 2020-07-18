extends Position2D

var grid_position: Vector2 = Vector2.ZERO

onready var parent: = get_parent()
onready var camera: Camera2D = $Camera
onready var grid_size: Vector2 = get_viewport().get_visible_rect().size


func _ready() -> void:
	set_as_toplevel(true)
	update_grid_position()


func _physics_process(delta: float) -> void:
	update_grid_position()


func update_grid_position() -> void:
	var x: = round(parent.position.x / grid_size.x)
	var y: = round(parent.position.y / grid_size.y)
	var new_grid_position: = Vector2(x, y)
	
	if grid_position == new_grid_position:
		return
	
	grid_position = new_grid_position
	position = grid_position * grid_size
