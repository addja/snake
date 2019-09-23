extends Sprite

# Member vars
var length = 0
var speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	length = 1
	speed = 500
	position = Vector2( get_viewport().get_visible_rect().size.x / 2, get_viewport().get_visible_rect().size.y / 2 )

# Main loop
func _process( delta ):
	position += acceleration() * delta
	position = screen_wrap( position )

# Acceleration logic
func acceleration():
	# Calculate movement direction
	var movement = Vector2( 0, 0 )
	if Input.is_action_pressed( "ui_up" ):
		movement.y -= 1
	if Input.is_action_pressed( "ui_down" ):
		movement.y += 1
	if Input.is_action_pressed( "ui_left" ):
		movement.x -= 1
	if Input.is_action_pressed( "ui_right" ):
		movement.x += 1
	return movement.normalized() * speed
	
# Wrap screen 
func screen_wrap( position ):
	var screenWidth = get_viewport().get_visible_rect().size.x
	var screenHeight = get_viewport().get_visible_rect().size.y
	if position.x < 0:
		position.x = screenWidth
	elif position.x > screenWidth:
		position.x = 0
	if position.y < 0:
		position.y = screenHeight
	elif position.y > screenHeight:
		position.y = 0
	return position