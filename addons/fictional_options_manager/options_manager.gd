extends Node

var config_to_load : String
var _config := ConfigFile.new()

var _config_sets :Dictionary[String, OptionsSection] = {}
func _init() -> void:
	config_to_load = ProjectSettings.get_setting(OptionsManagerConsts.config_file_path_settings_prop_path, OptionsManagerConsts.config_file_path_default)
	var type_names = ProjectSettings.get_setting(OptionsManagerConsts.config_file_sections_settings_prop_path)
	for type in type_names:
		var item := ClassUtils.get_type(type) as GDScript
		add_config_section(item.new())
	
func _ready():
	load_configuration()

func add_config_section_with_name(sectionName: String, type: OptionsSection) -> void:
	_config_sets[sectionName] = type
	
func add_config_section(type: OptionsSection) -> void:
	_config_sets[type.section_name] = type
	if _config.has_section(type.section_name):
		type.loadconfig(_config)


func load_configuration() -> void:
	_config.load(config_to_load)

	for cset: OptionsSection in _config_sets.values():
		if _config.has_section(cset.section_name):
			cset.loadconfig(_config)
		
	
	
func save_configuration() -> void:
	for cset: OptionsSection in _config_sets.values():
		cset.save(_config)
	
	_config.save(config_to_load)
		
func bind_notifcation(sectionName: String, callback: Callable) -> void:
	var found :OptionsSection = _config_sets.get(sectionName)
	if found != null:
		found.bind_notification(callback)
		callback.call(found)
