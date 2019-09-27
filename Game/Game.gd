extends Node2D

# Attributes
var snakeScene = preload( "res://Snake/Snake.tscn" )
var timeBuffer = 0

## Constants.
const TICK = 0.5
const TILESX = 10
const TILESY = 10

## Signals.
signal move

## Functions.
func game_over():
	for n in get_children():
		remove_child( n )
		n.queue_free()

func new_game():
	add_child( new_snake( TILESX / 2, TILESY / 2 ) )
	
func new_snake( x, y ):
	var snake = snakeScene.instance()
	snake.grid( TILESX, TILESY )
	snake.starting_position( x, y )
	connect( "move", snake, "on_Game_move" )
	return snake
	
func _process( delta ):
	timeBuffer += delta
	if ( timeBuffer > TICK ):
		timeBuffer = 0
		emit_signal( "move" )

func _ready():
	new_game()