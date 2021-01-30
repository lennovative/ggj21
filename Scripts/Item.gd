extends Area2D


func init(type: String):
	self.name = type
	var type_subnode = load("res://Scenes/Items/item_" + type + ".tscn").instance()
	type_subnode.set_scale(Vector2(0.5, 0.5))
	self.add_child(type_subnode)


func _on_Item_body_entered(body):
	if body.name == "player":
		body.item_in_range(self)

func _on_Item_body_exited(body):
	if body.name == "player":
		body.item_out_of_range(self)
