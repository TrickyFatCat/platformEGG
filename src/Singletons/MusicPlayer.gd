extends AudioStreamPlayer

enum mode {
	TRACK,
	SET
}

const MIN_VOLUME : float = -80.0

var music
var _current_mode

onready var default_volume : float = volume_db
onready var current_volume : float = MIN_VOLUME

func _init() -> void:
	connect("finished", self, "_on_track_finished")
	Events.connect("level_loaded", self, "_start_playing_music")
	TransitionScreen.connect("screen_opened", self, "_start_playing_music")
	TransitionScreen.connect("screen_closed", self, "_stop_playing_music")
	TransitionScreen.connect("screen_transit", self, "_change_volume_with_transition")
	
func _ready() -> void:
	_set_volume()

func _on_track_finished() -> void:
	match _current_mode:
		mode.TRACK:
			print_debug("Finished")
			pass
		mode.SET:
			pass


func play_music_track() -> void:
	pass


func play_music_set() -> void:
	pass


func _start_playing_music() -> void:
	playing = true


func _stop_playing_music() -> void:
	pass


func _set_volume() -> void:
	volume_db = current_volume


func _change_volume_with_transition() -> void:
	current_volume = lerp(MIN_VOLUME, default_volume, TransitionScreen.current_cutoff)
	_set_volume()
