extends State

const BOUNCE_FACTOR: Vector2 = Vector2(0.3, 0.5)
const WALL_BOUNCE_FACTOR: Vector2 = Vector2(0.35, 1)

var gravity: float = Global.GRAVITY
var velocity: Vector2 = Vector2.ZERO
var velocity_max: Vector2 = Vector2(600, 600)

onready var egg: Egg = Global.egg


func _ready() -> void:
	Events.connect("egg_took_damage", self, "on_damage_throw")
	Events.connect("player_took_egg", self, "reset_state")


func physics_process(delta: float) -> void:
	apply_gravity(delta)
	egg.move_and_slide(velocity, Global.FLOOR_NORMAL)


func enter(msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	pass


func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta
#	velocity.y = clamp(velocity.y, -velocity_max.y, velocity_max.y)


func apply_bounce() -> void:
	if egg.is_on_floor() or egg.is_on_ceiling():
		velocity.y *= -BOUNCE_FACTOR.y
		velocity.x *= BOUNCE_FACTOR.x
	
	if egg.is_on_wall():
		var direction = -sign(velocity.x)
		velocity.x *= -WALL_BOUNCE_FACTOR.x


func on_damage_throw() -> void:
	pass


func reset_state() -> void:
	velocity = Vector2.ZERO
	stateMachine.transition_to("Move/Idle")
