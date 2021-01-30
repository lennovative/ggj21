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
<<<<<<< Updated upstream
	spawnItem("book_blue", Vector2(-1250, 1050))
=======
		spawnItem("book_blue", Vector2(-1250, 1050))
>>>>>>> Stashed changes
	spawnItem("book_red", Vector2(1250, 1050))
	spawnItem("book_green", Vector2(1500, 1050))
	spawnItem("cat", Vector2(1775, 750))
	spawnItem("chest", Vector2(-1500, 800))
	spawnItem("coffee", Vector2(1050, 1050))
	#spawnItem("creeper_plush", Vector2())
	spawnItem("doll", Vector2(4250, 800))
	spawnItem("echolocator", Vector2(-4900, 1050))
	spawnItem("flour", Vector2(-1250, 1050))
	objective = spawnItem("glasses", Vector2(-1300, 800))
	spawnItem("ice_cubes", Vector2(4500, 1050))
	spawnItem("keys", Vector2(4250, 1050))
	spawnItem("yarn", Vector2(750, 1100))
	spawnItem("tv", Vector2(3750, 1050))
	spawnItem("vase_blue", Vector2(-4000, 500))
	spawnItem("vase_red", Vector2(-4000, 1050))
	spawnItem("vase_green", Vector2(4500, 500))
	spawnItem("tape", Vector2(-2350, 1050))
	spawnItem("magazine", Vector2(4500, 800))
#	spawnItem("magnet", Vector2(-, ))
	spawnItem("mtg_cards", Vector2(4250, 300))
#	spawnItem("phiranja_flower", Vector2(-, ))
	spawnItem("radio", Vector2(-2600, 500))
	spawnItem("spring_shoes", Vector2(-1500, 1050))
#	spawnItem("sword", Vector2(-, ))

	
func _process(delta):
	ambient.set_color(Globals.light_level)

func start_echolocate():
	objective.echolocate()
	get_node("Echolocate_timer").start(max(0.2, player.get_position().distance_to(objective.get_position())/1000))
	
func stop_echolocate():
	get_node("Echolocate_timer").stop()
