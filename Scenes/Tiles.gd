extends TileMap

var red_tiles : Array
var blue_tiles : Array

func _ready():
	#find red tiles
	var tile_id = get_tileset().find_tile_by_name("Red Block")
	red_tiles = get_used_cells_by_id(tile_id)
	#find blue tiles
	tile_id = get_tileset().find_tile_by_name("Blue Block")
	blue_tiles = get_used_cells_by_id(tile_id)
	
	update_tiles()

func update_tiles():
	var color = get_node("..").active
	if color == "red":
		for tile in red_tiles:
			set_cellv(tile,get_tileset().find_tile_by_name("Red Block"))
		for tile in blue_tiles:
			set_cellv(tile,get_tileset().find_tile_by_name("Blue Dots"))
	else:
		for tile in red_tiles:
			set_cellv(tile,get_tileset().find_tile_by_name("Red Dots"))
		for tile in blue_tiles:
			set_cellv(tile,get_tileset().find_tile_by_name("Blue Block"))
