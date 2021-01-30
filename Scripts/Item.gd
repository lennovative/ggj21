extends Area2D

func _ready():
	name = "item1"

func _on_Item_body_entered(body):
	if body.name == "player":
		body.item_in_range(self)

func _on_Item_body_exited(body):
	if body.name == "player":
		body.item_out_of_range(self)
