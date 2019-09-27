extends "res://GridObject/GridObject.gd"

## Attributes.
var step = Vector2( 0, 0 )

## Functions.
func on_Game_move():
	tiledPosition += step
	coord_to_position()

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

func _process( delta ):
	player_step()
	
func _ready():
	step = Vector2( 1, 0 )