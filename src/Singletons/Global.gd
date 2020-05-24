extends Node

const FLOOR_NORMAL: Vector2 = Vector2.UP
const GRAVITY: float = 3000.0

var player: Player
var egg: Egg


static func calculate_arch_velocity(
		start_point: Vector2, 
		target_point: Vector2, 
		arc_height: float, 
		up_gravity: float = Global.GRAVITY,
		down_gravity: float = -1
	):
	if down_gravity == -1:
		down_gravity = up_gravity
	
	var velocity: = Vector2.ZERO
	var displacement: = start_point - target_point
	var time_up = sqrt(-2 * arc_height / up_gravity)
	var time_down = sqrt(2 * (displacement.y - arc_height) / down_gravity)
	velocity.y = -sqrt(-2 * up_gravity * arc_height)
	velocity.x = displacement.x / float(time_up + time_down)
	
	return velocity
