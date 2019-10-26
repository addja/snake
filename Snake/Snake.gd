extends GridObject

# Attributes.
var head = false
var eaten = false
var oldStep = Vector2( -2, -2 )
var snakeTexture = preload( "res://Assets/Snake.png" )
var snakeAppleTexture = preload( "res://Assets/SnakeAteApple.png" )
var step = Vector2( 0, 0 )

# Functions.
func eat():
	eaten = true
	texture = snakeAppleTexture

func follow():
	coord_to_position()

func move():
	coord += step
	oldStep = step
	follow()

func end_eat():
		eaten = false
		texture = snakeTexture
	
func new_snake( coord, grid ):
	var snake = get_script().new()
	snake.grid = grid
	snake.coord = coord
	snake.position = position
	return snake

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
	if head:
		player_step()
	
func _ready():
	step = Vector2( 1, 0 )