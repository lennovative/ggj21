extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect("size_changed", self, "window_resized")
	window_resized()


func window_resized():
	var position = Vector2(OS.get_window_size().x - 100, OS.get_window_size().y - 100)
	get_node("inventory_background").set_position(position)
	get_node("item_sprite").set_position(position)
