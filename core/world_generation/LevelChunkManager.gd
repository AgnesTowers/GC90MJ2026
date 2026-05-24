@tool
extends Node2D
class_name LevelChunkManager

@export_tool_button("Generate Mountain") var generate_mountain_button = generate_chunks

@export_group("Slope")
@export var slope_noise: Noise
@export var noise_sample_resolution: float = 1.0
@export var noise_power: float = 1.0
@export var mountain_slope_curve: Curve
@export_group("Chunks")
@export var mountain_size_in_chunks: Vector2i = Vector2i(16, 16)
@export var initial_number_of_chunks: int = 16
@export var chunk_size: Vector2i = Vector2i(32, 18)
@export var ground_depth: int = 24
@export_group("Tilesets")
@export var foreground_tile_set: TileSet
@export var platform_tile_set: TileSet
@export var background_tile_set: TileSet
@export_group("Chunk Features")
@export var feature_palette: ChunkFeaturePalette
@export var base_features_per_chunk: int = 0
@export var feature_variance: int = 0

var level_chunks: Array[Chunk] = []

@onready var base_chunk_scene = preload("res://core/world_generation/chunk.tscn")

func _ready() -> void:
	generate_chunks()

func generate_chunks() -> void:
	
	for child in get_children():
		child.free()
	
	for i: int in range(initial_number_of_chunks):
		generate_chunk(i)

func generate_chunk(chunk_number: int) -> void:
	
	var new_chunk: Chunk = base_chunk_scene.instantiate()
	add_child(new_chunk, true)
	new_chunk.owner = get_tree().edited_scene_root
	
	
	new_chunk.position.x = chunk_number * chunk_size.x * platform_tile_set.tile_size.x
	
	new_chunk.chunk_number = chunk_number
	new_chunk.chunk_size = chunk_size
	new_chunk.ground_depth = ground_depth
	
	new_chunk.foreground_tile_map_layer.tile_set = foreground_tile_set
	new_chunk.platforms_tile_map_layer.tile_set = platform_tile_set
	new_chunk.background_tile_map_layer.tile_set = background_tile_set
	
	var platform_heights: Array[int] = []
	for x: int in range(chunk_size.x):
		var offset: float = (chunk_number as float * chunk_size.x as float + x as float) / (mountain_size_in_chunks.x as float * chunk_size.x as float)
		var slope_fac: float = mountain_slope_curve.sample(offset)
		var noise_fac: float = abs(slope_noise.get_noise_1d(offset * noise_sample_resolution))
		platform_heights.append((slope_fac * mountain_size_in_chunks.y * chunk_size.y) + noise_fac * noise_power)
	new_chunk.generate_base_terrain(platform_heights)
	
	new_chunk.mirror_tile_maps_layers()
	
	pass
