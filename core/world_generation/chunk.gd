@tool
extends Node2D
class_name Chunk

var chunk_number: int

@onready var holder: Node2D = $TileMapLayerHolder
@onready var mirror: TileMapLayerMirror = $TileMapLayerMirror
@onready var foreground_tile_map_layer: TileMapLayer = $TileMapLayerHolder/Foreground
@onready var platforms_tile_map_layer: TileMapLayer = $TileMapLayerHolder/Platforms
@onready var background_tile_map_layer: TileMapLayer = $TileMapLayerHolder/Background


func _ready() -> void:
	
	mirror.source_tile_map_layers.append_array(holder.get_children())

func generate_base_terrain(heights: Array[int]) -> void:
	
	for x: int in range(heights.size()):
		for y: int in range(heights[x] + 1):
			platforms_tile_map_layer.set_cell(Vector2i(x,-y), 0, Vector2i(1, 3))
		
	
	platforms_tile_map_layer.update_internals()

func mirror_tile_maps_layers() -> void:
	mirror.mirror_tile_map_layers()
