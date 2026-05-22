extends Node2D
class_name ChunkFeature

@export var boundary_size: Vector2i = Vector2i(0, 0)
@export var terrain_gap_boundary_size: Vector2i = Vector2i(0, 0)

@export var lower_vertical_position_bounds: int = 0
@export var upper_vertical_position_bounds: int = 0
@export var min_x_buffer_in_tiles = 1

var x_offset_in_chunk = 0
