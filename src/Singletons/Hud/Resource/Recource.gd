tool
extends HBoxContainer

export var icon: StreamTexture

onready var res_value: Label = $Value


func _ready() -> void:
    if Engine.editor_hint:
        $Icon.texture = icon


func set_recourse_value(value: String) -> void:
    res_value.text = value