extends HBoxContainer

onready var res_value: Label = $Value


func set_resource_value(value) -> void:
	res_value.text = "x" + String("%02d" % value)
