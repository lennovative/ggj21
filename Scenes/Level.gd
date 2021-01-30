extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var an_item = preload("res://Scenes/Item.tscn").instance()
	an_item.init("radio")
	an_item.set_position(Vector2(500, 1100))
	self.add_child(an_item)
	
	

