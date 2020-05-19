extends State

export(Vector2) var max_velocity_default = Vector2(250.0, 1500.0)
export(Vector2) var acceleration_default = Vector2(1500.0, 3000.0)
export(Vector2) var friction_default = Vector2(1500.0, 300.0)
export(float) var jump_impulse = 600.0
export(float) var stunlock_impulse = 400.0

var acceleration: Vector2 = acceleration_default
var friction: Vector2 = friction_default
var max_velocity: Vector2 = max_velocity_default
var velocity: Vector2 = Vector2.ZERO

onready var sprite: AnimatedSprite = get_node("../../Sprite")
onready var eggController: EggController = get_node("../../EggController")


func _on_DamageDetector_area_entered(area: Area2D) -> void:
	stateMachine.transition_to("Move/Stunlock", { 
		impulse = stunlock_impulse,
		direction = get_move_direction(),
		area_position = area.global_position
	})


func unhandled_input(event: InputEvent) -> void:
	if owner.is_on_floor() && event.is_action_pressed("jump") && !eggController.is_with_egg:
		stateMachine.transition_to("Move/Air", { velocity = Vector2(300 * get_move_direction().x, 0), impulse = jump_impulse })


func physics_process(delta: float) -> void:
	var direction = get_move_direction()
	calculate_velocity_x(delta, direction)
	apply_gravity(delta)
	velocity = owner.move_and_slide(velocity, Global.FLOOR_NORMAL)
	Events.emit_signal("player_moved", owner)
	
	if get_move_direction().x > 0:
		sprite.flip_h = false
	elif get_move_direction().x < 0:
		sprite.flip_h = true


func calculate_velocity_x(delta: float, direction: Vector2) -> void:
	if direction.x != 0 and abs(velocity.x) <= max_velocity.x:
		velocity.x += acceleration.x * direction.x * delta
		velocity.x = clamp(velocity.x, -max_velocity.x, max_velocity.x)
	elif velocity.x != 0 or abs(velocity.x) > max_velocity.x:
		direction.x = -sign(velocity.x)
		velocity.x += friction.x * direction.x * delta
		
		if direction.x < 0:
			velocity.x = max(velocity.x, 0)
		elif direction.x > 0:
			velocity.x = min(velocity.x, 0)


func calculate_velocity_y(impulse: float, direction: float):
	velocity.y = impulse * direction


func apply_gravity(delta: float) -> void:
	velocity.y += acceleration.y * delta


static func get_move_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		1.0
	)
