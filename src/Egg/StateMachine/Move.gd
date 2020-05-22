extends State

const BOUNCE_FACTOR: float = 0.7

var gravity: float = Global.GRAVITY
var velocity: Vector2 = Vector2.ZERO
var direction: float = 0.0
var friction: float = 250

onready var egg: Egg = Global.egg


func physics_process(delta: float) -> void:
	direction = -sign(velocity.x)
	velocity.x += friction * direction * delta
	
	if direction < 0:
		velocity.x = max(velocity.x, 0)
	elif direction > 0:
		velocity.x = min(velocity.x, 0)
	
	apply_gravity(delta)
	egg.move_and_slide(velocity, Global.FLOOR_NORMAL)
	apply_bounce()


func enter(msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	pass


func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta


func apply_bounce() -> void:
	if egg.is_on_floor():
		velocity.y *= -BOUNCE_FACTOR
	
	if egg.is_on_wall():
		direction *= -sign(velocity.x)
		velocity.x *= direction * BOUNCE_FACTOR
	
	if egg.is_on_ceiling():
		velocity.y = 0
