extends Node2D

onready var ambient = get_node("CanvasModulate")
const ITEM_CLASS = preload("res://Scenes/Item.tscn")
var items = []
var objective
onready var player = get_node("YSort/player")
const POSITIONS = [Vector2(-3300, 500), Vector2(-2500, 1050), Vector2(-2600, 100), Vector2(-1250, 1050), Vector2(1250, 1050), Vector2(1500, 1050), 
	Vector2(1775, 750), Vector2(-1500, 800), Vector2(1050, 1050), Vector2(-1300, 1050), Vector2(4250, 800), Vector2(-4900, 1050), Vector2(-1250, 1050), 
	Vector2(-1350, 800), Vector2(4500, 1050), Vector2(4300, 1050), Vector2(4500, 800), Vector2(4250, 300), Vector2(-2400, 500), Vector2(-1500, 1050), 
	Vector2(4500, 500), Vector2(-2300, 1050), Vector2(-6400, 1050), Vector2(-4100, 500), Vector2(-4000, 1050), Vector2(-4500, 500), Vector2(750, 1100),
	Vector2(-200, 1050), Vector2(-3200, 1050), Vector2(-5000, 650), Vector2(-4800, 650), Vector2(-4950, 1000), Vector2(-4750, 1000), 
	Vector2(-5050, 0), Vector2(-4700, 0), Vector2(-3200, 1050)]

# Instances an item of given type and adds it to the scene at the given position (x, y)
func spawnItem(type:String, position: Vector2):
	var an_item = ITEM_CLASS.instance()
	an_item.init(type)
	an_item.set_position(position)
	get_node("YSort").add_child(an_item)
	return an_item


# Called when the node enters the scene tree for the first time.
func _ready():
	print("spawning " + String(items.size()) + " items on " + String(POSITIONS.size()) + " positions")
	spawnItem("coffee", Vector2(400, 950))
	
	spawnItem("echolocator", Vector2(-6600, 1050))
	
	spawnItem("spring_shoes", Vector2(-500, 1050))
	
	for i in range (items.size()):
		items[i].set_position(POSITIONS[min(i, POSITIONS.size()-1)])
		get_node("YSort").add_child(items[i])
		


	
func adjust_light(light_level: Color):
	ambient.set_color(light_level)

func start_echolocate():
	print("locate" + String(objective.type) + " at " + String(objective.get_position()))
	objective.echolocate()
	get_node("Echolocate_timer").start(max(0.2, player.get_position().distance_to(objective.get_position())/1000))
	
func stop_echolocate():
	get_node("Echolocate_timer").stop()
