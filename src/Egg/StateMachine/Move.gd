extends State

const BOUNCE_FACTOR: Vector2 = Vector2(0.3, 0.5)
const WALL_BOUNCE_FACTOR: Vector2 = Vector2(0.2, 1)

var gravity: float = Global.GRAVITY
var velocity: Vector2 = Vector2.ZERO
var max_velocity: Vector2 = Vector2(-1, 600)
var is_gravity_enabled: bool = true setget set_is_gravity_enabled
var frames_count: int = 0
var zero_gravity_frames: int = 10

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
	velocity.y = clamp(velocity.y, -max_velocity.y, max_velocity.y)


func apply_bounce() -> void:
	if egg.is_on_floor() or egg.is_on_ceiling():
		velocity.y *= -BOUNCE_FACTOR.y
		velocity.x *= BOUNCE_FACTOR.x
	
	if egg.is_on_wall():
		var direction = -sign(velocity.x)
		velocity.x *= -WALL_BOUNCE_FACTOR.x


func set_is_gravity_enabled(value: bool) -> void:
	is_gravity_enabled = false
	
	if value:
		gravity = 0
	else:
		gravity = Global.GRAVITY
		frames_count = 0


func switch_gravity() -> void:
	if is_gravity_enabled:
		frames_count += 1
		
		if frames_count == zero_gravity_frames:
			self.is_gravity_enabled = true
