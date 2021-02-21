extends State

const AIR_CONTROL_DEFAULT : float = 1.0
const SNAP_VECTOR_DEFAULT : Vector2 = Vector2.DOWN * 8

var velocity : Vector2 = Vector2.ZERO
var movement_buffer : int = 3
var movement_buffer_counter : int = 0
var is_coyote_time_active : bool = false

onready var player : Player = Global.player
onready var sprite : AnimatedSprite = player.get_node("Sprite")
onready var acceleration : Vector2 = player.acceleration
onready var velocity_max : Vector2 = player.velocity_max
onready var velocity_jump : Vector2 = player.velocity_jump
onready var velocity_stunlock : Vector2 = player.velocity_stunlock
onready var gravity : float = Global.GRAVITY
onready var friction : float = player.ground_friction
onready var air_control_factor : float = AIR_CONTROL_DEFAULT
onready var jump_sound : String = "res://sounds/sfx_goose.wav"


func _on_DamageDetector_area_entered(area: Area2D) -> void:
	var is_death_trigger = false
	
	if area is DeathTrigger:
		Global.player.global_position = area.teleportation_position
		is_death_trigger = true
		
	transit_to_stunlock(area.global_position, is_death_trigger)


func _on_DamageDetector_body_entered(body: PhysicsBody2D) -> void:
	transit_to_stunlock(body.global_position)


func unhandled_input(event: InputEvent) -> void:
	flip_sprite()
	
	if player.is_on_floor() and event.is_action_pressed("jump") and !player.is_with_egg:
		apply_jump()
	
	if event.is_action_pressed("throw"):
		player.throw_egg()
	
	if event.is_action_pressed("interact"):
		player.take_egg()


func physics_process(delta: float) -> void:
	var direction = get_move_direction()
	calculate_velocity_x(delta, direction)
	apply_gravity(delta)
	velocity = player.move_and_slide_with_snap(velocity, SNAP_VECTOR_DEFAULT, Global.FLOOR_NORMAL)


func calculate_velocity_x(delta: float, direction: Vector2) -> void:
	if direction.x != 0 and abs(velocity.x) <= velocity_max.x:
		velocity.x += acceleration.x * air_control_factor * direction.x * delta
		velocity.x = clamp(velocity.x, -velocity_max.x, velocity_max.x)
	elif velocity.x != 0 or abs(velocity.x) > velocity_max.x:
		direction.x = -sign(velocity.x)
		velocity.x += friction * direction.x * delta
		
		if direction.x < 0:
			velocity.x = max(velocity.x, 0)
		elif direction.x > 0:
			velocity.x = min(velocity.x, 0)


func apply_jump() -> void:
	stateMachine.transition_to("Move/Jump", { velocity = velocity_jump, direction = get_move_direction() })
	AudioPlayer.play(jump_sound)


func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = clamp(velocity.y, -velocity_max.y, velocity_max.y)


func get_move_direction() -> Vector2:
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = -1 if Input.is_action_just_pressed("jump") else 1
	return direction if stateMachine.is_processing_unhandled_input() else Vector2.ZERO


func calculate_jump_velocity(velocity_new: Vector2, direction: Vector2) -> void:
	velocity = velocity_new * direction


func transit_to_stunlock(hazard_position: Vector2, is_death_trigger : bool = false) -> void:
	stateMachine.transition_to("Move/Stunlock", { 
		velocity = velocity_stunlock,
		direction = get_move_direction(),
		hazard_position = hazard_position,
		is_death_trigger = is_death_trigger
	})


func flip_sprite() -> void:
	if get_move_direction().x > 0:
		sprite.flip_h = false
	elif get_move_direction().x < 0:
		sprite.flip_h = true
