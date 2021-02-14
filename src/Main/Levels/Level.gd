extends Node
class_name Level

const MUSIC_FADE_DURATION : float = 1.5

export(bool) var is_hud_active := true
export(Vector2) var camera_zoom := Vector2(1, 1)
export(Array, String, FILE, "*.wav") var music := []

var level_time : float = 0


func _init() -> void:
	Global.current_level = self


func _ready() -> void:
	GameCamera.zoom = camera_zoom
	Hud.is_active = is_hud_active
	Events.emit_signal("level_loaded")
	_start_playing_music()


func _start_playing_music() -> void:
	if music.empty():
		return
	elif music.size() == 1:
		var track = load(music[0])
		MusicPlayer.play_track(track, MUSIC_FADE_DURATION)
	else:
		var track = load(music[randi() % music.size()])
		MusicPlayer.play_track(track, MUSIC_FADE_DURATION)
