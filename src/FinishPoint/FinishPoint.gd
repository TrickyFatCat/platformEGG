extends Area2D

var is_player_inside: bool = false
var is_egg_inside: bool = false


func _on_body_entered(body: PhysicsBody2D) -> void:
	is_body_player(body)
	is_body_egg(body)
	
	if is_player_inside and is_egg_inside:
		# TODO add result window call here
		Events.emit_signal("open_finish_screen")
		Global.call_deferred("deactivate_player")


func _on_body_exited(body: PhysicsBody2D) -> void:
	is_body_player(body)
	is_body_egg(body)


func is_body_player(body: PhysicsBody2D) -> void:
	if body is Player:
		is_player_inside = !is_player_inside
		is_egg_inside = Global.player.is_with_egg


func is_body_egg(body: PhysicsBody2D) -> void:
	if body is Egg:
		is_egg_inside = !is_egg_inside
