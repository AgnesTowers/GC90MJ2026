@tool
extends Node2D
class_name TileMapLayerMirror

@export var source_tile_map_layers: Array[TileMapLayer]
@export var mirror_offest: Vector2 = Vector2(0, 0)


@export_tool_button("Mirror TileMapLayers") var mirror_action = mirror_tile_map_layers
@export_tool_button("Clear TileMapLayer") var clear_action = free_tile_maps


func mirror_tile_map_layers() -> void:
	
	free_tile_maps()
	
	for tile_map_layer in source_tile_map_layers:
	
		if tile_map_layer.tile_set != null:
	
			var new_tile_map_layer = TileMapLayer.new()
		
			new_tile_map_layer.tile_set = tile_map_layer.tile_set
			new_tile_map_layer.tile_map_data = tile_map_layer.tile_map_data
			new_tile_map_layer.scale.y = - tile_map_layer.scale.y
			
			new_tile_map_layer.position.x = new_tile_map_layer.tile_set.tile_size.x * mirror_offest.x
			new_tile_map_layer.position.y = new_tile_map_layer.tile_set.tile_size.y * mirror_offest.y
			
			add_child(new_tile_map_layer, true)
			new_tile_map_layer.owner = get_tree().edited_scene_root
			
			tile_map_layer.changed.connect(func() -> void:
				print(0)
				)

func free_tile_maps() -> void:
	for child in get_children():
		if child is TileMapLayer:
			child.free()
