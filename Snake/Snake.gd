extends GridObject

# Attributes.
var snakeAte = false
var snakeTexture = preload( "res://Assets/Snake.png" )
var snakeAppleTexture = preload( "res://Assets/SnakeAteApple.png" )
var step = Vector2( 0, 0 )

# Functions.
func grow():
	snakeAte = true
	texture = snakeAppleTexture
	# TODO make snake grow

func move():
	tiledPosition += step
	coord_to_position()
	if snakeAte:
		snakeAte = false
		texture = snakeTexture

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
		step = movement

func _init():
	texture = snakeTexture  # This cannot be in the parent class

func _process( delta ):
	player_step()
	
func _ready():
	step = Vector2( 1, 0 )