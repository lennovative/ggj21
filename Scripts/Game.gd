extends Node2D

enum Scene {LEVEL, OFFICE}
var current_scene = Scene.OFFICE
var Level = preload("res://Scenes/Level.tscn").instance()
var Office = preload("res://Scenes/Office.tscn").instance()
var first_scene = true
var current_item = null
var target_name1 = null
var target_name2 = null
var target_name3 = null
var delivered = [false, false, false]
const item_names = ["mug", "ball_basket", "ball_volley", "ball_white", "ball_wilson", "book_blue", "book_green", "book_red", "book_stack", "bowl", "candle_new", "candle_old", "cat_still", "chest", "coffee", "creeper_plush", "doll", "echolocator", "flour", "glasses", "ice_cube", "magazine", "magnet", "mtg_cards", "phiranja_flower", "picture", "plant", "radio", "spring_shoes", "sword", "tape", "tea_cup", "triforce", "tv", "twig", "vase_blue", "vase_green", "vase_red", "walking_aid", "wrench", "yarn"]

func _ready():
	target_name1 = "cat_still"
	target_name2 = get_random_item([target_name1])
	target_name3 = get_random_item([target_name1, target_name2])
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
		print("deliver")
		var name = current_item.type if current_item.type != "cat" else "cat_still"
		match name:
			target_name1:
				delivered[0] = true
				$Office.get_node("WantedBoard").get_node("done1").visible = true
			target_name2:
				delivered[1] = true
				$Office.get_node("WantedBoard").get_node("done2").visible = true
			target_name3:
				delivered[2] = true
				$Office.get_node("WantedBoard").get_node("done3").visible = true
		current_item = null
		delete_children($Inventory.get_node("item_sprite"))
		win()

func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

func win():
	if delivered[0] and delivered[1] and delivered[2]:
		get_new_targets()
	# TODO

func set_sprites():
	$Office.get_node("WantedBoard").get_node("target_item1").set_texture(load("res://Assets/Graphics/items/item_" + target_name1 + ".png"))
	$Office.get_node("WantedBoard").get_node("target_item2").set_texture(load("res://Assets/Graphics/items/item_" + target_name2 + ".png"))
	$Office.get_node("WantedBoard").get_node("target_item3").set_texture(load("res://Assets/Graphics/items/item_" + target_name3 + ".png"))


func get_new_targets():
	$Office.get_node("WantedBoard").get_node("done1").visible = false
	$Office.get_node("WantedBoard").get_node("done2").visible = false
	$Office.get_node("WantedBoard").get_node("done3").visible = false
	target_name1 = get_random_item([])
	target_name2 = get_random_item([target_name1])
	target_name3 = get_random_item([target_name1, target_name2])
	set_sprites()

func get_random_item(exceptions):
	var item_id = int(rand_range(0, item_names.size() - 1))
	var item = item_names[item_id]
	while exceptions.count(item) > 0:
		item_id = int(rand_range(0, item_names.size() - 1))
		item = item_names[item_id]
	return item
