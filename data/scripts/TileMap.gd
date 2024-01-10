extends TileMap

var desert1 = FastNoiseLite.new()
var width = 128
var height = 128
@onready var player = get_parent().get_child(1)

func _ready():
	desert1.seed = randi()

func _process(delta):
	generate_chunk(player.position)
	
func generate_chunk(position):
	var tile_pos = local_to_map(position)
	for x in range(width):
		for y in range(height):
			var desert = desert1.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*10
			set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2i(round((desert+10)/5), round((desert+10)/5)))
			#set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2i(0,0))
			
