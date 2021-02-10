extends AudioStreamPlayer

enum mode {
	TRACK,
	SET
}

const MIN_VOLUME : float = -80.0
const FADE_TIME : float = 0.75

var music
var _current_mode
var _tracks
var _fade_tween : Tween
var volume_factor : float = 0.0

onready var default_volume : float = volume_db
onready var current_volume : float = MIN_VOLUME

func _init() -> void:
	connect("finished", self, "_on_track_finished")
	_fade_tween = Tween.new()
	self.add_child(_fade_tween)
	_fade_tween.connect("tween_all_completed", self, "_on_fade_ended")


func _ready() -> void:
	_set_volume(0.0)
	TransitionScreen.connect("screen_opened", self, "_start_playing_music")
	TransitionScreen.connect("screen_closed", self, "_stop_playing_music")

func _on_track_finished() -> void:
	match _current_mode:
		mode.TRACK:
			print_debug("Finished")
			pass
		mode.SET:
			pass

func _on_fade_ended() -> void:
	if playing and volume_factor == 0.0:
		playing = false

func play_music_track(track : AudioStream) -> void:
	_current_mode = mode.TRACK
	pass


func play_music_set(tracks) -> void:
	_current_mode = mode.SET
	self._tracks = tracks
	pass


func _start_playing_music() -> void:
	playing = true
	_fade_in()


func _stop_playing_music() -> void:
	_fade_out()


func _set_volume(volume_factor: float) -> void:
	self.volume_factor = volume_factor
	current_volume = lerp(MIN_VOLUME, default_volume, volume_factor)
	volume_db = current_volume


func _fade_in() -> void:
	_start_tween(0.0, 1.0)


func _fade_out() -> void:
	_start_tween(1.0, 0.0)


func _start_tween(initial_value: float, target_value: float) -> void:
	_fade_tween.interpolate_method(
		self,
		"_set_volume",
		initial_value,
		target_value,
		FADE_TIME,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	_fade_tween.start()






















