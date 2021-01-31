extends Node2D

enum Scene {LEVEL, OFFICE}
var current_scene = Scene.OFFICE
var Level = preload("res://Scenes/Level.tscn")
var Office = preload("res://Scenes/Office.tscn")

func _ready():
	load_office()

func load_office():
	current_scene = Scene.OFFICE
	add_child(Office.instance())

func load_level():
	current_scene = Scene.LEVEL
	add_child(Level.instance())

func clear():
	for n in self.get_children():
		self.remove_child(n)
		n.queue_free()

func switch_scene():
	clear()
	match current_scene:
		Scene.OFFICE:
			load_level()
		Scene.LEVEL:
			load_office()
