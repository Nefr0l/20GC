extends Node2D

@export var dot_object : PackedScene
@export var wall_tile_id : int = 0
@export var floor_tile_id : int = 1

func _ready() -> void:
	Game.nodes = []
	Game.walls = []
	Game.power_pellets = []
	Game.floors = []
	
	get_nodes()
	place_dots.call_deferred()	
		
		
func get_nodes() -> void:
	var tiles = Game.tilemap
	
	for t in tiles.get_used_cells():	
		var tile_id = tiles.get_cell_source_id(t)
		var point = Vector2(t.x * Game.grid_size + Game.grid_offset, t.y * Game.grid_size + Game.grid_offset)

		if tile_id == wall_tile_id:
			Game.walls.append(point)
			continue	
		elif tile_id == floor_tile_id:
			Game.floors.append(point)
		
		var right = is_neighbor_wall(tiles, t, TileSet.CELL_NEIGHBOR_RIGHT_SIDE)
		var left = is_neighbor_wall(tiles, t, TileSet.CELL_NEIGHBOR_LEFT_SIDE)
		var up = is_neighbor_wall(tiles, t, TileSet.CELL_NEIGHBOR_TOP_SIDE)
		var down = is_neighbor_wall(tiles, t, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)
		
		if (not (up and down) and not (left and right)):
			Game.nodes.append(point)	


func is_neighbor_wall(tiles : TileMapLayer, coords : Vector2, direction : TileSet.CellNeighbor) -> bool:
	var tile = tiles.get_neighbor_cell(coords, direction)
	return tiles.get_cell_source_id(tile) == wall_tile_id
	
	
func place_dots() -> void:	
	for f in Game.floors:
		if f in Game.power_pellets: continue
		
		var dot = dot_object.instantiate() as Area2D
		dot.position = f
		Game.total_points += 1
		add_child(dot)
	
