@tool
extends Node
class_name TileMapLayerMirror

@export var source_tile_map_layer: TileMapLayer
@export var target_tile_map_layer: TileMapLayer
@export var mirror_plane_y: int = 0

var tile_mirror_mapping: Dictionary[int, int] = {0: 2, 1: 1,2: 0 }

@export_tool_button("Mirror TileMapLayer") var mirror_action = mirror_tile_map

func mirror_tile_map() -> void:
	
	target_tile_map_layer.tile_set = source_tile_map_layer.tile_set
	target_tile_map_layer.tile_map_data = source_tile_map_layer.tile_map_data
	target_tile_map_layer.scale.y = - source_tile_map_layer.scale.y
	
	pass
