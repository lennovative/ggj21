extends Node2D

onready var ambient = get_node("CanvasModulate")
const ITEM_CLASS = preload("res://Scenes/Item.tscn")
var objective
onready var player = get_node("YSort/player")


# Instances an item of given type and adds it to the scene at the given position (x, y)
func spawnItem(type:String, position: Vector2):
	var an_item = ITEM_CLASS.instance()
	an_item.init(type)
	an_item.set_position(position)
	get_node("YSort").add_child(an_item)
	return an_item


# Called when the node enters the scene tree for the first time.
func _ready():
	spawnItem("cat", Vector2(1775, 750))
	spawnItem("radio", Vector2(-2600, 500))
	objective = spawnItem("glasses", Vector2(-1300, 800))
	spawnItem("coffee", Vector2(1050, 1050))
	spawnItem("yarn", Vector2(300, 1100))
	spawnItem("echolocator", Vector2(200, 1100))
	spawnItem("spring_shoes", Vector2(0, 1100))

	
func _process(delta):
	ambient.set_color(Globals.light_level)

func start_echolocate():
	objective.echolocate()
	get_node("Echolocate_timer").start(max(0.2, player.get_position().distance_to(objective.get_position())/1000))
	
func stop_echolocate():
	get_node("Echolocate_timer").stop()
