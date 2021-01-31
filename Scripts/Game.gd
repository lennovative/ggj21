extends Node2D

enum Scene {LEVEL, OFFICE}
var current_scene = Scene.OFFICE
var Level = preload("res://Scenes/Level.tscn").instance()
var Office = preload("res://Scenes/Office.tscn").instance()
var first_scene = true
var current_item = null
var targets = [null, null, null]
var delivered = [false, false, false]
const item_names = ["cat", "ball_basket", "ball_volley", "ball_white", "ball_wilson", "book_blue", "book_green", "book_red", "book_stack", "bowl", "candle_new", "candle_old", "chest", "creeper_plush", "doll", "flour", "glasses", "ice_cubes", "magazine", "magnet", "mtg_cards", "phiranja_flower", "picture", "plant", "radio", "sword", "tape", "tea_cup", "triforce", "tv", "twig", "vase_blue", "vase_green", "vase_red", "walking_aid", "wrench", "yarn"]
const ITEM_CLASS = preload("res://Scenes/Item.tscn")
var items = []
var found_items = []

func _ready():
	for item_name in item_names:
		var new_item = ITEM_CLASS.instance()
		new_item.init(item_name)
		items.append(new_item)
	targets[0] = items[0]
	targets[1] = get_random_item(targets)
	targets[2] = get_random_item(targets)
	Level.items = items
	Level.objective = targets[0]
	load_office()
	randomize()

func load_office():
	current_scene = Scene.OFFICE
	add_child(Office)

func load_level():
	current_scene = Scene.LEVEL
	add_child(Level)

func switch_scene():
	if first_scene:
		$Inventory.get_node("inventory_background").visible = true
		first_scene = false
	match current_scene:
		Scene.OFFICE:
			self.remove_child(Office)
			load_level()
		Scene.LEVEL:
			self.remove_child(Level)
			load_office()

func item_deliver():
	if current_item != null:
		print("deliver" + current_item.name + " expecting: " + targets[0].name + " or " + targets[1].name + " or " + targets[2].name)
		var correct_item = false
		for i in range(3):
			if current_item == targets[i]:
				delivered[i] = true
				$Office.get_node("WantedBoard").get_node("done" + String(i+1)).visible = true
				current_item = null
				correct_item = true
			if delivered[i] and targets[i] == Level.objective and not i == 2:
				Level.objective = targets[i+1]
		show_message("nice" if correct_item else "wrong")
		delete_children($Inventory.get_node("item_sprite"))
		win()
	else:
		show_message("no_item")

func show_message(type):
	$Office.get_node("Grandma").speak(type)

func remove_current_item():
	current_item = null
	delete_children($Inventory.get_node("item_sprite"))

func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

func win():
	if delivered[0] and delivered[1] and delivered[2]:
		get_new_targets()
	# TODO

func set_sprites():
	$Office.get_node("WantedBoard").get_node("target_item1").set_texture(load("res://Assets/Graphics/items/item_" + targets[0].type + ".png"))
	$Office.get_node("WantedBoard").get_node("target_item2").set_texture(load("res://Assets/Graphics/items/item_" + targets[1].type + ".png"))
	$Office.get_node("WantedBoard").get_node("target_item3").set_texture(load("res://Assets/Graphics/items/item_" + targets[2].type + ".png"))


func get_new_targets():
	$Office.get_node("WantedBoard").get_node("done1").visible = false
	$Office.get_node("WantedBoard").get_node("done2").visible = false
	$Office.get_node("WantedBoard").get_node("done3").visible = false
	targets[0] = get_random_item(found_items)
	targets[1] = get_random_item(found_items + targets)
	targets[2] = get_random_item(found_items + targets)
	Level.objective = targets[0]
	for i in range (3):
		delivered[i] = false
	set_sprites()

func get_random_item(exceptions):
	var item_id = randi() % items.size()
	var item = items[item_id]
	while exceptions.count(item) > 0:
		item_id = randi() % items.size()
		item = items[item_id]
	return item
