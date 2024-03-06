extends TileMap

@warning_ignore("narrowing_conversion")
@export var widht = 256
@export var height = 256
var fnl = FastNoiseLite.new()
@onready var tile_map = $"."

const boundary_atlas_pos = Vector2i(5, 0)
const main_source = 0

enum layers{
	level0 = 0,
	level1 = 1,
}

func _ready():
	generateWorld()
	place_boundaries()
	fnl = FastNoiseLite.new()
	fnl.seed = randi_range(0, 10000) 
	fnl.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	fnl.frequency = 0.015
	fnl.fractal_octaves = 1.5
	

func generateWorld():
	for x in widht:
		for y in height:
			if fnl.get_noise_2d(x, y) > -0.25:
				tile_map.set_cell(layers.level0, Vector2(x, y), main_source, Vector2(0, 0))
				
func place_boundaries():
	var offsets = [
		Vector2i(0, -1),
		Vector2i(0, 1),
		Vector2i(1, 0),
		Vector2i(-1, 0)
	]
	var used = get_used_cells(layers.level0)
	for spot in used:
		for offset in offsets:
			var current_spot = spot + offset
			if get_cell_source_id(layers.level0, current_spot) == -1:
				set_cell(layers.level0, current_spot, main_source, boundary_atlas_pos)
				
