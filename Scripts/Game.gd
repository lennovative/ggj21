extends Node2D

enum Scene {LEVEL, OFFICE}
var current_scene = Scene.OFFICE
var Level = preload("res://Scenes/Level.tscn").instance()
var Office = preload("res://Scenes/Office.tscn").instance()
var first_scene = true
var current_item = null

func _ready():
	load_office()

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
