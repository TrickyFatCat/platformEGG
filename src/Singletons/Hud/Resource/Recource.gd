extends HBoxContainer

export(int, 2, 5) var zero_count := 2

onready var res_value: Label = $Value


func set_resource_value(value) -> void:
	var zeros: = "%0" + String(zero_count) + "d"
	res_value.text = "x" + String(zeros % value)
