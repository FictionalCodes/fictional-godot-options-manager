@tool
extends Node

var CONFIG_FILE_PATH: String

@onready var _config := ConfigFile.new()

var configSets :Dictionary[String, OptionsSection] = {

}

func _init() -> void:
	CONFIG_FILE_PATH = ProjectSettings.get_setting(OptionsManagerConsts.config_file_path_settings_prop_path)

func _ready():
	_config.load(CONFIG_FILE_PATH)
	LoadConfiguration()

func AddConfigSection(sectionName: String, type: OptionsSection) -> void:
	configSets[sectionName] = type

func LoadConfiguration() -> void:
	for cset: OptionsSection in configSets.values():
		if _config.has_section(cset.SectionName):
			cset.load(_config)
	
	
func SaveConfiguration() -> void:
	for cset: OptionsSection in configSets.values():
		cset.save(_config)
	
	_config.save(CONFIG_FILE_PATH)
		
func BindNotification(sectionName: String, callback: Callable) -> void:
	var found :OptionsSection = configSets.get(sectionName)
	if found != null:
		found.BindNotification(callback)
