extends Area2D
class_name PlayerTrigger

signal player_entered
signal player_exited
signal trigger_activated
signal trigger_deactivated

export(bool) var is_interactable: = false
export(bool) var is_triggered_once: = false

var is_player_inside: bool = false
var is_activated: bool = false


func _on_body_entered(_body: Player) -> void:
	is_player_inside = true
	emit_signal("player_entered")

	match is_triggered_once:
		true:
			if not is_interactable:
				_activate_trigger()
			pass

		false:
			if not is_activated and not is_interactable:
				_activate_trigger()
			pass


func _on_body_exited(_body: Player) -> void:
	is_player_inside = false
	emit_signal("player_exited")

	match is_triggered_once:
		true:
			if not is_interactable:
				_deactivate_trigger()
			pass
		
		false:
			if is_activated and not is_interactable:
				_deactivate_trigger()

				
func _unhandled_input(event: InputEvent) -> void:
	if is_interactable and event.is_action_pressed("interact"):
		match is_activated:
			true:
				if not is_triggered_once:
					_deactivate_trigger()
				pass
					
			false:
				_activate_trigger()
				pass


func _activate_trigger() -> void:
	is_activated = true
	emit_signal("trigger_activated")


func _deactivate_trigger() -> void:
	is_activated = false
	emit_signal("trigger_deactivated")
