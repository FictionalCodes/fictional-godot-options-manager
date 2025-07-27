class_name AudioManager
extends Node


func _ready() -> void:
	FictionalOptionsManager.bind_notifcation("Audio", update_audio_levels)
	
	
var master_bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("Effects")

func update_audio_levels(options: AudioOptions):
	set_bus_volume(master_bus, options.MasterVolume/100.0, options.MasterMuted)
	set_bus_volume(music_bus, options.MusicVolume/100.0, options.MusicMuted)
	set_bus_volume(sfx_bus, options.EffectVolume/100.0, options.EffectMuted)


func set_bus_volume(index : int, value : float, mute: bool):
	var calcedLogValue = linear_to_db(value)

	AudioServer.set_bus_volume_db(index, calcedLogValue)
	AudioServer.set_bus_mute(index, (is_zero_approx(value) or mute))


