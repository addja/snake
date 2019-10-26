extends Node2D

# Attributes.
var apple
var appleScene = preload( "res://Apple/Apple.tscn" )
var grid = Vector2( 10, 10 )
var snake = []
var snakeScene = preload( "res://Snake/Snake.tscn" )
var timeBuffer = 0

# Constants.
const TICK = 0.5

# Functions.
func free_position():
	var free = []
	for i in range( grid.x ):
		for j in range( grid.y ):
			free.append( Vector2( i, j ) )
	for piece in snake:
		free.remove( piece.coord.x * grid.x + piece.coord.y )
		print( piece.coord )
	print( free )
	return free[ randi() % free.size() ]
	# TODO compute free positions and get one

func game_over():
	for n in get_children():
		remove_child( n )
		n.queue_free()
	snake = []

func move_snake():
	var snakeSize = snake.size()
	if snake.back().eaten:
		snake.back().end_eat()
		snake.append( snakeScene.instance().new_snake( snake.back().coord, grid ) )
		add_child( snake.back() )
	for i in range( snakeSize -1, 0, -1 ):
			snake[ i ].coord = snake[ i - 1 ].coord
			snake[ i ].follow()
			if snake[ i -1 ].eaten:
				snake[ i - 1 ].end_eat()
				snake[ i ].eat()
	if snake.size() > 1 && snake[ 0 ].step == -snake[ 0 ].oldStep:
		snake[ 0 ].step = snake[ 0 ].oldStep
	snake[ 0 ].move()

func new_apple():
	apple = appleScene.instance()
	apple.grid = grid
	apple.coord = free_position()

func new_game():
	snake.append( snakeScene.instance().new_snake( grid / 2, grid ) )
	snake[ 0 ].head = true
	new_apple()
	add_child( snake[ 0 ] )
	add_child( apple )

func ouroboros():
	var headCoord = snake[ 0 ].coord
	for i in range( 1, snake.size() ):
		if snake[ i ].coord == headCoord:
			game_over()
			new_game()
			return

func process_collisions():
	if snake[ 0 ].coord == apple.coord:
		snake[ 0 ].eaten = true
		remove_child( apple )
		new_apple()
		add_child( apple )

func _process( delta ):
	timeBuffer += delta
	if ( timeBuffer > TICK ):
		timeBuffer = 0
		process_collisions()
		move_snake()
		ouroboros()
		

func _ready():
	new_game()