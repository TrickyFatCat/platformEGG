extends State

var acceleration_x: float = 10000.0
var max_velocity_x: float = 125.0
var stunlock_direction: Vector2 = Vector2.UP

onready var move: State = get_parent()
onready var SpriteNode: AnimatedSprite = get_node("../../../Sprite")


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	var direction: = Vector2(stunlock_direction.x, 1)
	move.calculate_velocity_x(delta, direction)
	move.apply_gravity(delta)
	move.velocity = owner.move_and_slide(move.velocity, owner.FLOOR_NORMAL)
	
	if owner.is_on_ceiling():
		move.velocity.y = 0
	
	Events.emit_signal("player_moved", owner)


func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
#	move.acceleration.x = acceleration_x
	move.max_velocity.x = max_velocity_x
#	move.friction.x = 0
	SpriteNode.play("stunlock")
	
#	if "direction" in msg:
#		if msg.direction.x != 0:
#			stunlock_direction.x = -msg.direction.x
#		else:
	stunlock_direction.x = 1.0 if SpriteNode.flip_h else -1.0
	
	move.velocity.x = stunlock_direction.x * max_velocity_x
	
	if "area_position" in msg:
		if move.velocity.y != 0:
			move.velocity.y = 0
		
		if msg.area_position.y > owner.global_position.y:
			print(msg.area_position.y, " | ", owner.global_position.y)
			if "impulse" in msg:
				
				move.calculate_velocity_y(msg.impulse, stunlock_direction.y)


func exit() -> void:
	move.exit()
	move.acceleration.x = move.acceleration_default.x
	move.max_velocity.x = move.max_velocity_default.x
	move.friction.x = move.friction_default.x
