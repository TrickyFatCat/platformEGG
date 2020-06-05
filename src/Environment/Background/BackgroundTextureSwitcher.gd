extends TextureRect

var textures = [
	load("res://assets/Backgrounds/bg_blue.png"),
	load("res://assets/Backgrounds/bg_brown.png"),
	load("res://assets/Backgrounds/bg_gray.png"),
	load("res://assets/Backgrounds/bg_green.png"),
	load("res://assets/Backgrounds/bg_pink.png"),
	load("res://assets/Backgrounds/bg_purple.png"),
	load("res://assets/Backgrounds/bg_yellow.png")
]


func _ready() -> void:
	randomize()
	var index = randi() % textures.size()
	texture = textures[index]
