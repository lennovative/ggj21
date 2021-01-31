extends Node2D

#onready var ambient = get_node("CanvasModulate")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().set_sprites()
