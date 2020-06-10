extends State

onready var egg: Egg = Global.egg
onready var sprite: AnimatedSprite = egg.get_node("Sprite")


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func enter(msg: Dictionary = {}) -> void:
	sprite.play("death")
	stateMachine.set_physics_process(false)
	stateMachine.set_process_unhandled_input(false)
	yield(get_tree(), "idle_frame")
	egg.is_active = false


func exit() -> void:
	pass
