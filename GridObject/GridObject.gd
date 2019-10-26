extends Sprite

class_name GridObject

# Attributes.
var coord = Vector2( 0, 0 )
var grid = Vector2( 0, 0 )
var spriteOffset = Vector2( 0, 0 )
var spriteScale = Vector2( 0, 0 )

# Functions.
func coord_to_position():
	coord = wrap_map()
	position = coord * spriteScale + spriteOffset

func prepare_sprite():
	spriteScale = Vector2( self.get_viewport().get_visible_rect().size.x / grid.x,
						   self.get_viewport().get_visible_rect().size.y / grid.y )
	self.set_scale( spriteScale / self.get_texture().get_size() )
	spriteOffset = spriteScale / 2

func wrap_map():
	if coord.x >= grid.x:
		coord.x = 0
	elif coord.x < 0:
		coord.x = grid.x - 1
	if coord.y >= grid.y:
		coord.y = 0
	elif coord.y < 0:
		coord.y = grid.y - 1
	return coord

func _ready():
	prepare_sprite()
	coord_to_position()