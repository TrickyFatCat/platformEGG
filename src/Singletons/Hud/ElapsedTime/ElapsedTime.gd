extends Label

func _process(delta: float) -> void:
	if not LevelLoader.is_level_timer_active:
		text = "00:00.000"
		return
		
	var time = LevelLoader.level_time
	var minutes = time / 60
	var seconds = int(time) % 60
	var miliseconds = int(fmod(time, seconds) * 1000)
	text = "%02d:%02d.%03d" % [minutes, seconds, miliseconds]
