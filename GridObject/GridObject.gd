extends Sprite

class_name GridObject

## Attributes.
var spriteOffset = Vector2( 0, 0 )
var spriteScale = Vector2( 0, 0 )
var tiledPosition = Vector2( 0, 0 )
var tiles = Vector2( 0, 0 )

## Functions.
func coord_to_position():
	tiledPosition = wrap_map( tiledPosition )
	position = tiledPosition * spriteScale + spriteOffset

func grid( tilesX, tilesY ):
	tiles = Vector2( tilesX, tilesY )

func prepare_sprite():
	spriteScale = Vector2( self.get_viewport().get_visible_rect().size.x / tiles.x,
		self.get_viewport().get_visible_rect().size.y / tiles.y )
	self.set_scale( spriteScale / self.get_texture().get_size() )
	spriteOffset = spriteScale / 2

func starting_position( x, y ):
	tiledPosition = Vector2( x, y )

func wrap_map( pos ):
	if pos.x >= tiles.x:
		pos.x = 0
	elif pos.x < 0:
		pos.x = tiles.x - 1
	if pos.y >= tiles.y:
		pos.y = 0
	elif pos.y < 0:
		pos.y = tiles.y - 1
	return pos
	
func _ready():
	prepare_sprite()
	coord_to_position()