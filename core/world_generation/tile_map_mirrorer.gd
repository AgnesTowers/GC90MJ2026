@tool
extends Node
class_name TileMapLayerMirror

@export var tile_map_layer: TileMapLayer
@export var mirror_plane_y: int = 0

var tile_mirror_mapping: Dictionary[int, int] = {0: 2, 1: 1,2: 0 }

@export_tool_button("Mirror TileMapLayer") var mirror_action = mirror_tile_map

func mirror_tile_map() -> void:
	
	print(7)
	
	var used_cells: Array[Vector2i] = tile_map_layer.get_used_cells()
	var mirror_cells : Array[Vector3i] = []
	
	for cell: Vector2i in used_cells:
		if cell.y < mirror_plane_y:
			mirror_cells.append(Vector3i(cell.x, mirror_plane_y + (mirror_plane_y - cell.y) -1 , tile_mirror_mapping.get(tile_map_layer.get_cell_atlas_coords(cell).y)))
		else:
			tile_map_layer.erase_cell(cell)
	
	print(mirror_cells)
	
	for cell: Vector3i in mirror_cells:
		tile_map_layer.set_cell(Vector2i(cell.x, cell.y), 1, Vector2i(0, cell.z))
	
	tile_map_layer.update_internals()
	pass
