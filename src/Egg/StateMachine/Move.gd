extends State

const BOUNCE_FACTOR: float = 0.8

var gravity: float = Global.GRAVITY
var velocity: Vector2 = Vector2.ZERO
var direction: float = -1.0

onready var egg: Egg = Global.egg


func physics_process(delta: float) -> void:
	var direction_f = -sign(velocity.x)
	velocity.x += 50 * direction_f * delta
	
	if direction_f < 0:
		velocity.x = max(velocity.x, 0)
	elif direction_f > 0:
		velocity.x = min(velocity.x, 0)
	
	apply_gravity(delta)
	var previous_velocity_y: = velocity.y
	egg.move_and_slide(velocity, Global.FLOOR_NORMAL)
	
	if egg.is_on_floor() and previous_velocity_y != 0:
		velocity.y *= -BOUNCE_FACTOR
	
	if egg.is_on_wall():
		direction *= -sign(velocity.x)
		velocity.x *= direction * BOUNCE_FACTOR
	
	if egg.is_on_ceiling():
		velocity.y = 0
	
	print(velocity.x)
	


func enter(msg: Dictionary = {}) -> void:
	return


func exit() -> void:
	return


func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta
