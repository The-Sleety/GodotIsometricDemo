extends TileMap

const boundary_atlas_pos = Vector2i(5, 0)
const main_source = 0

enum layers{
	level0 = 0,
	level1 = 1,
}

func _ready():
	place_boundaries()
	place_walls()

func place_walls():
	var offsets = [
		Vector2i(0, -1),
		Vector2i(-1, 0)
	]
	var used = get_used_cells(layers.level1)
	for spot in used:
		for offset in offsets:
			var current_spot = spot + offset
			if get_cell_source_id(layers.level1, current_spot) == -1:
				set_cell(layers.level1, current_spot, main_source, boundary_atlas_pos)

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

