extends Node

enum input_device {
	KEYBOARD,
	PS4,
	XBOX
}

const JOY_DEADZONE : float = 0.25
const JOY_ID_DEFAULT : int = 0

var current_input_device : int = input_device.KEYBOARD
var joy_id_current : int = JOY_ID_DEFAULT


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		current_input_device = input_device.KEYBOARD
		Events.emit_signal("input_device_changed", current_input_device)
		return

	if event is InputEventJoypadButton:
		joy_id_current = event.device

		match Input.get_joy_name(joy_id_current):
			"PS4 Controller":
				current_input_device = input_device.PS4
				pass
			"XInput Gamepad":
				current_input_device = input_device.XBOX
				pass
			
		Events.emit_signal("input_device_changed", current_input_device)
		return
