tool
class_name FlashController
extends Node

const MIN_FLASH_ALPHA: float = 0.0
const MAX_FLASH_ALPHA: float = 1.0

export(NodePath) var target_sprite
export(float) var flash_duration: = 0.35

var is_active: bool = false setget set_is_active

onready var flash_shader: ShaderMaterial = get_node(target_sprite).material


func _get_configuration_warning() -> String:
	var warning: String = "Target sprite must be chosen."
	return warning if !target_sprite else ""


func _ready() -> void:
	if not Engine.editor_hint:
		GlobalTween.connect("tween_completed", self, "restart_tween")


func set_is_active(value: bool) -> void:
	is_active = value
	
	if value:
		start_flash()
	else:
		pass


func set_flash_shader() -> void:
	flash_shader = get_node(target_sprite).material


func set_flash_alpha(value: float) -> void:
	value = clamp(value, MIN_FLASH_ALPHA, MAX_FLASH_ALPHA)
	flash_shader.set_shader_param("u_alpha", value)


func start_flash() -> void:
# warning-ignore:return_value_discarded
		GlobalTween.interpolate_method(
			self,
			"set_flash_alpha",
			MAX_FLASH_ALPHA,
			MIN_FLASH_ALPHA,
			flash_duration,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN
		)
# warning-ignore:return_value_discarded
		GlobalTween.start()


func restart_tween(object: Object, key: NodePath) -> void:
	if is_active and object == self:
		start_flash()
