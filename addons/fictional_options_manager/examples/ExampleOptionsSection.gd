class_name ExampleOptionsSection extends OptionsSection

var _myExample : int = 6
var MyExample: int:
	get: 
		return _myExample
	set(value):
		_myExample= value
		
var _notifyExample : String = "Low"
var NotifyExample: String:
	get: 
		return _notifyExample
	set(value):
		_notifyExample= value
		NotifyChange()

func _init(section: String) -> void:
	super._init(section)
	
	configKeyMap["myExample"] = &"MyExample"
