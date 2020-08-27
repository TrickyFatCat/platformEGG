extends Label

const TIME : String = "%02d:%02d.%03d"




func _process(delta: float) -> void:
	var time = LevelLoader.level_time
	var minutes = time / 60
	var seconds = int(time) % 60
	var miliseconds = int(fmod(time, seconds) * 1000)

	if not LevelLoader.is_level_timer_active or miliseconds < 0:
		minutes = 0
		seconds = 0
		miliseconds = 0

	text = TIME % [minutes, seconds, miliseconds]
