extends Node


signal player_spawned()
# warning-ignore:unused_signal
signal player_took_damage()
# warning-ignore:unused_signal
signal player_dead()
# warning-ignore:unused_signal
signal player_took_egg()
# warning-ignore:unused_signal
signal player_threw_egg()
# warning-ignore:unused_signal
signal egg_took_damage()
# warning-ignore:unused_signal
signal egg_dead()
signal fruit_earned()
# warning-ignore:unused_signal
signal level_loaded()
signal level_started()
signal level_exited()
signal level_restarted()
signal level_finished()
signal show_level_data(level_id, difficulty)
signal hide_level_data()
signal open_finish_screen()
signal input_device_changed()