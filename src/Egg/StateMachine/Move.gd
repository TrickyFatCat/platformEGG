extends State

const BOUNCE_FACTOR: Vector2 = Vector2(0.55, 0.6)
const WALL_BOUNCE_FACTOR: Vector2 = Vector2(0.25, 1)

var gravity: float = Global.GRAVITY
var velocity: Vector2 = Vector2.ZERO

onready var egg: Egg = Global.egg


func physics_process(delta: float) -> void:
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
	if egg.is_on_floor() or egg.is_on_ceiling():
		velocity.y *= -BOUNCE_FACTOR.y
		velocity.x *= BOUNCE_FACTOR.x
	
	if egg.is_on_wall():
		var direction = -sign(velocity.x)
		velocity.x *= direction * WALL_BOUNCE_FACTOR.x
