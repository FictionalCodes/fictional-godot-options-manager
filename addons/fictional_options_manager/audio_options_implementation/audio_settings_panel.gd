class_name AudioSettingsPanel
extends Control

var _options : AudioOptions = null

@export var _masterSlider : Slider
@export var _musicSlider : Slider
@export var _effectsSlider : Slider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	OptionsManager.bind_notifcation(&"Audio", set_slider_values)

func set_slider_values(options:AudioOptions) -> void:
	_masterSlider.set_value_no_signal(_options.MasterVolume)
	_effectsSlider.set_value_no_signal(_options.EffectVolume)
	_musicSlider.set_value_no_signal(_options.MasterVolume)
	


func _on_master_volume_slider_value_changed(value: float) -> void:
	_options.MasterVolume = value


func _on_music_volume_slider_value_changed(value: float) -> void:
	_options.MusicVolume = value


func _on_effects_volume_slider_value_changed(value: float) -> void:
	_options.EffectVolume = value


func _on_tree_exiting() -> void:
	OptionsManager.save_configuration()
