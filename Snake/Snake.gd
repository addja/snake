extends Sprite

## Attributes 
var spriteOffset = Vector2( 0, 0 )
var spriteScale = Vector2( 0, 0 )
var step = Vector2( 0, 0 )
var tiledPosition = Vector2( 0, 0 )
var timeBuffer = 0

## Constants
const TICK = 0.5
const TILESX = 10
const TILESY = 10

## Functions
# Initialize sprite manipulation variables
func init_sprite():
	spriteScale = Vector2( self.get_viewport().get_visible_rect().size.x / TILESX,
					 	   self.get_viewport().get_visible_rect().size.y / TILESY )
	self.set_scale( spriteScale / self.get_texture().get_size() )
	spriteOffset = spriteScale / 2

# Buffer the player's last movement decision
func player_step():
	var movement = Vector2( 0, 0 )
	if Input.is_action_pressed( "ui_up" ):
		movement.y -= 1
	if Input.is_action_pressed( "ui_down" ):
		movement.y += 1
	if Input.is_action_pressed( "ui_left" ):
		movement.x -= 1
	if Input.is_action_pressed( "ui_right" ):
		movement.x += 1
	if movement != Vector2( 0, 0 ):
		return movement
	return step

# If the snake goes to a side of the map, it comes in the other side
func wrap_map( pos ):
	if pos.x >= TILESX:
		pos.x = 0
	elif pos.x < 0:
		pos.x = TILESX - 1
	if pos.y >= TILESY:
		pos.y = 0
	elif pos.y < 0:
		pos.y = TILESY - 1
	return pos

 # Called when the node enters the scene tree for the first time.
func _ready():
	init_sprite()
	tiledPosition = Vector2( TILESX / 2, TILESY / 2 )
	position = tiledPosition * spriteScale + spriteOffset
	step = Vector2( 1, 0 )

# Main loop
func _process( delta ):
	timeBuffer += delta
	step = player_step()
	if ( timeBuffer > TICK ):
		timeBuffer = 0
		tiledPosition += step
		tiledPosition = wrap_map( tiledPosition )
		position = tiledPosition * spriteScale + spriteOffset