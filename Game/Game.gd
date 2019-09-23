extends Node2D

var snakeScene = preload( "res://Snake/Snake.tscn" )

func _ready():
	add_child( snakeScene.instance() )