@tool
class_name OptionsSection extends RefCounted

var _section: String
var SectionName: String:
	get: return _section

var _suppressNotifications: bool = false
var _notification: Signal = Signal(self, &"NotifyChanges")

func _init( section: String):
	_section = section

var configKeyMap : Dictionary[String, StringName] = {

}

var _revertCopy: Dictionary

func addValue(name: String, propName:StringName) -> void:
	configKeyMap.set(name, propName)

func save(config:ConfigFile) -> void:
	for item in configKeyMap:
		config.set_value(_section, item, get(configKeyMap[item]))
	
func _load(config:ConfigFile) ->void:
	_suppressNotifications = true
	for item in configKeyMap:
		set(configKeyMap.get(item),config.get_value(_section, item, get(configKeyMap[item])))
	_suppressNotifications = false
	NotifyChange()

func apply(config: ConfigFile) -> void:
	save(config)
	NotifyChange()

func StartEdit() -> void:
	_revertCopy = configKeyMap.duplicate()

func Revert() -> void:
	configKeyMap = _revertCopy.duplicate()
	NotifyChange()
	
func NotifyChange() -> void:
	if !_suppressNotifications:
		_notification.emit(self)

func BindNotification(callback: Callable) ->void:
	_notification.connect(callback, ConnectFlags.CONNECT_DEFERRED)
