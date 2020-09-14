extends Node

enum input_device {
	KEYBOARD,
	GAMEPAD
}

const JOY_DEADZONE : float = 0.25
const JOY_ID_DEFAULT : int = 0

var current_input_device : int = input_device.KEYBOARD
var joy_id_current : int = JOY_ID_DEFAULT


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey or event is InputEventMouse:
		current_input_device = input_device.KEYBOARD
		Events.emit_signal("input_device_changed", current_input_device)
		return

	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		joy_id_current = event.device
		current_input_device = input_device.GAMEPAD
		Events.emit_signal("input_device_changed", current_input_device)
		return
