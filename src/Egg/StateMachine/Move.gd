extends State

const BOUNCE_FACTOR: Vector2 = Vector2(0.35, 0.5)
const WALL_BOUNCE_FACTOR: Vector2 = Vector2(0.35, 1)

var gravity: float = Global.GRAVITY
var velocity: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.ZERO

onready var egg: Egg = Global.egg
onready var on_damage_impulse: Vector2 = egg.on_damage_impulse


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


func apply_bounce() -> void:
	if egg.is_on_floor() or egg.is_on_ceiling():
		velocity.y *= -BOUNCE_FACTOR.y
		velocity.x *= BOUNCE_FACTOR.x
	
	if egg.is_on_wall():
		velocity.x *= -WALL_BOUNCE_FACTOR.x
	
	egg.velocity = velocity


func on_damage_throw(hazard_position: Vector2) -> void:
	if direction == Vector2.ZERO:
		var is_hazard_beneath = hazard_position.y <= egg.global_position.y
		direction.x = sign(velocity.x)
		direction.y = 1 if is_hazard_beneath else -1
	
	stateMachine.transition_to("Move/Soar", { velocity = on_damage_impulse, direction = direction })


func reset_state() -> void:
	velocity = Vector2.ZERO
	stateMachine.transition_to("Move/Idle")
