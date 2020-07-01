extends Camera2D

onready var cameraShaker : Node = $CameraShaker


func _ready() -> void:
# warning-ignore:return_value_discarded
	Events.connect("player_took_damage", self, "activate_player_shake")
# warning-ignore:return_value_discarded
	Events.connect("egg_took_damage", self, "activate_egg_shake")


func activate_player_shake() -> void:
	cameraShaker.start(0.2, 50, 1)


func activate_egg_shake() -> void:
	cameraShaker.start(0.2, 50, 2, 1)
