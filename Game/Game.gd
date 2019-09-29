extends Node2D

# Attributes.
var apple
var appleScene = preload( "res://Apple/Apple.tscn" )
var snake
var snakeScene = preload( "res://Snake/Snake.tscn" )
var timeBuffer = 0

# Constants.
const TICK = 0.5
const TILESX = 10
const TILESY = 10

# Functions.
func free_position():
	return Vector2( randi() % TILESX, randi() % TILESY )
	# TODO compute free positions and get one

func game_over():
	for n in get_children():
		remove_child( n )
		n.queue_free()

func new_apple():
	apple = appleScene.instance()
	apple.grid( TILESX, TILESY )
	apple.starting_position( free_position() )

func new_game():
	new_snake( TILESX / 2, TILESY / 2 )
	new_apple()
	add_child( snake )
	add_child( apple )
	
func new_snake( x, y ):
	snake = snakeScene.instance()
	snake.grid( TILESX, TILESY )
	snake.starting_position( Vector2( x, y ) )

func process_collisions():
	if snake.tiledPosition == apple.tiledPosition:
		snake.grow()
		remove_child( apple )
		new_apple()
		add_child( apple )

func _process( delta ):
	timeBuffer += delta
	if ( timeBuffer > TICK ):
		timeBuffer = 0
		snake.move()
		process_collisions()

func _ready():
	new_game()