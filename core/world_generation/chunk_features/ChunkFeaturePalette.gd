@tool
extends Resource
class_name ChunkFeaturePalette

var chunk_feature_folder_path: String = "res://core/world_generation/chunk_features/"
@export_tool_button("Reload Chunk Features","ReloadSmall") var load_chunk_features_action = load_scene_paths

var all_features: Dictionary[String, String]  = {}
var included_features: Dictionary[String, String]  = {}
var _features: int = 0:
	get:
		return _features
	set(value):
		_features = value
		print(value)
		var keys: Array[String] = all_features.keys()
		for i: int in range(all_features.size()):
			
			if pow(2, i) as int & value:
				included_features.set(keys[i], all_features.get(keys[i]))
			else:
				included_features.erase(keys[i])
			
		print(included_features)

func _init() -> void:
	load_scene_paths()

func _get_property_list():
	
	var properties = []
	
	properties.append({
		"name" : "_features",
		"type" : TYPE_INT,
		"hint" : PROPERTY_HINT_FLAGS,
		"hint_string" : _array_to_string(all_features.keys())
	})
	
	properties.append({
		"name" : "all_features",
		"type" : TYPE_DICTIONARY,
		"hint" : PROPERTY_HINT_NONE,
		"usage": PROPERTY_USAGE_STORAGE
	})
	properties.append({
		"name" : "included_feature",
		"type" : TYPE_DICTIONARY,
		"hint" : PROPERTY_HINT_NONE,
		"usage": PROPERTY_USAGE_STORAGE
	})

	
	return properties

func load_scene_paths() -> void:
	var dir: DirAccess = DirAccess.open(chunk_feature_folder_path)
	
	for path: String in  dir.get_files():
		if path.ends_with(".tscn"):
			all_features.set(path.left(-5), chunk_feature_folder_path + path)
	
	notify_property_list_changed()

#converts array to string
func _array_to_string(arr: Array[String], separator = ",") -> String:
	var string: String = ""
	for i: String in arr:
		string += str(i) + separator
	return string
