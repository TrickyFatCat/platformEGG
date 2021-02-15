extends StaticBody2D

onready var playerCheck : RayCast2D = $PlayerCheck
onready var collision : CollisionShape2D = $Collision


func _process(_delta: float) -> void:
	if playerCheck.is_colliding():
		collision.disabled = true
	elif collision.disabled == true:
		collision.disabled = false
