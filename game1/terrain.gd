extends Node2D

@onready var grass_tilemap:TileMap = get_node("grass")
@onready var water_tile:TileMap=get_node("water")
var grass_used_cells:Array
# Called when the node enters the scene tree for the first time.
func _ready():
	var used_grass_rect:Rect2 = grass_tilemap.get_used_rect()
	grass_used_cells=grass_tilemap.get_used_cells(0)
	watertile(used_grass_rect)
	

func watertile(used_rect: Rect2)->void:
	for x in range(used_rect.position.x - 10, used_rect.size.x+10):
		for y in range(used_rect.position.y - 10, used_rect.size.y+10):
			if grass_used_cells.has(Vector2i(x,y)):
				continue
			water_tile.set_cell(
				0,
				Vector2i(x,y),
				0,
				Vector2i(0,0))
