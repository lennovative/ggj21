extends Node2D

onready var ambient = get_node("CanvasModulate")


# Instances an item of given type and adds it to the scene at the given position (x, y)
func spawnItem(type:String, position: Vector2):
	var an_item = preload("res://Scenes/Item.tscn").instance()
	an_item.init(type)
	an_item.set_position(position)
	self.add_child(an_item)


# Called when the node enters the scene tree for the first time.
func _ready():
	spawnItem("cat", Vector2(1775, 750))
	spawnItem("radio", Vector2(-2600, 500))
	spawnItem("glasses", Vector2(-1300, 800))
	spawnItem("coffee", Vector2(1050, 1050))
	spawnItem("yarn", Vector2(300, 1100))


	
func _process(delta):
	ambient.set_color(Globals.light_level)

