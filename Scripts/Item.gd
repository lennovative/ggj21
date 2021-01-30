extends KinematicBody2D

var vel = Vector2.ZERO
var type

func init(type: String):
	self.type = type
	var type_subnode = load("res://Scenes/Items/item_" + type + ".tscn").instance()
	type_subnode.set_scale(Vector2(0.5, 0.5))
	self.add_child(type_subnode)
	
	#self.set_collision_layer_bit(0, false);
	#self.set_collision_mask_bit(0, false);
	#self.set_collision_layer_bit(1, true);
	#self.set_collision_mask_bit(1, true);


func _on_PickupArea_body_entered(body):
	if body.name == "player":
		body.item_in_range(self)
func _on_PickupArea_body_exited(body):
	if body.name == "player":
		body.item_out_of_range(self)

func _physics_process(delta):
	vel.y += Globals.GRAVITY * delta
	vel = move_and_slide(vel, Vector2(0, -1))
	
func echolocate():
	get_node("Echolocate").play()
	

