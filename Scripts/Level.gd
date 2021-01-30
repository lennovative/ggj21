extends Node2D

const GRAVITY = 1200

onready var ambient = get_node("CanvasModulate")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func get_gravity():
	return GRAVITY

# Called when the node enters the scene tree for the first time.
func _ready():
	var an_item = preload("res://Scenes/Item.tscn").instance()
	an_item.init("radio")
	an_item.set_position(Vector2(500, 1100))
	self.add_child(an_item)
	
	var yarn_item = preload("res://Scenes/Item.tscn").instance()
	yarn_item.init("yarn")
	yarn_item.set_position(Vector2(300, 1100))
	self.add_child(yarn_item)
	
func _process(delta):
	ambient.set_color(Globals.light_level)

