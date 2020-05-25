extends State

#export(Vector2) var velocity_max_default: = Vector2(250.0, 600.0)
#export(Vector2) var acceleration_default: = Vector2(1500.0, 3000.0)
#export(Vector2) var friction_default: = Vector2(1700.0, 300.0)
#export(float) var jump_impulse: = 600.0
#export(float) var jump_velocity_x: = 325.0
#export(float) var stunlock_impulse: = 400.0

var velocity: Vector2 = Vector2.ZERO
var movement_buffer: int = 3
var movement_buffer_counter: int = 0

onready var player: Player = Global.player
onready var sprite: AnimatedSprite = player.get_node("Sprite")
onready var eggController: EggController = player.get_node("EggController")
onready var acceleration: Vector2 = player.acceleration
onready var velocity_max: Vector2 = player.velocity_max
onready var velocity_jump: Vector2 = player.velocity_jump
onready var velocity_stunlock: Vector2 = player.velocity_stunlock
onready var gravity: float = Global.GRAVITY
onready var friction: float = player.ground_friction


func _on_DamageDetector_area_entered(area: Area2D) -> void:
	transit_to_stunlock(area.global_position)


func _on_DamageDetector_body_entered(body: PhysicsBody2D) -> void:
	transit_to_stunlock(body.global_position)


func unhandled_input(event: InputEvent) -> void:
	if player.is_on_floor() and event.is_action_pressed("jump") and !eggController.is_with_egg:
		var velocity_jump_x: = velocity_jump.x * get_move_direction().x
		stateMachine.transition_to("Move/Jump", { velocity = Vector2(velocity_jump_x, velocity_jump.y) })
	pass


func physics_process(delta: float) -> void:
	var direction = get_move_direction()
	calculate_velocity_x(delta, direction)
	apply_gravity(delta)
	flip_sprite()
	velocity = owner.move_and_slide(velocity, Global.FLOOR_NORMAL)


func calculate_velocity_x(delta: float, direction: Vector2) -> void:
	if direction.x != 0 and abs(velocity.x) <= velocity_max.x:
		velocity.x += acceleration.x * direction.x * delta
		velocity.x = clamp(velocity.x, -velocity_max.x, velocity_max.x)
	elif velocity.x != 0 or abs(velocity.x) > velocity_max.x:
		direction.x = -sign(velocity.x)
		velocity.x += friction * direction.x * delta
		
		if direction.x < 0:
			velocity.x = max(velocity.x, 0)
		elif direction.x > 0:
			velocity.x = min(velocity.x, 0)


func calculate_velocity_y(impulse: float, direction: float):
	velocity.y = impulse * direction


func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = clamp(velocity.y, -velocity_max.y, velocity_max.y)


static func get_move_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		1.0
	)


func transit_to_stunlock(position: Vector2) -> void:
	stateMachine.transition_to("Move/Stunlock", { 
		impulse = velocity_stunlock.y,
		direction = get_move_direction(),
		area_position = position
	})
	Events.emit_signal("player_took_damage")


func flip_sprite() -> void:
	if get_move_direction().x > 0:
		sprite.flip_h = false
	elif get_move_direction().x < 0:
		sprite.flip_h = true
