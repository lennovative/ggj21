extends KinematicBody2D

var vel = Vector2()
var gravity = Globals.GRAVITY
var walkspeed = 400
var jumpSpeed = 800
var acc = 1700
var items_in_range = []
var current_item = null
var item = load("res://Scenes/Item.tscn")
var can_enter = false
onready var drop_timer = get_node("drop_timer")
var sprite_dir = "right"
onready var level = get_node("/root/Game/Level")

# Called when the node enters the scene tree for the first time.
func _ready():
	name = "player"

func get_input():
	var x_speed = Input.get_action_strength("right_button") - Input.get_action_strength("left_button")
	return x_speed



func anim_switch(animation):
	var new_anim = str(animation, sprite_dir)
	if $AnimationPlayer:
		if $AnimationPlayer.current_animation != new_anim:
			$AnimationPlayer.play(new_anim)

func _physics_process(delta):
	var target_speed = get_input() * walkspeed
	vel.x = move_toward(vel.x, target_speed, delta * acc)# * abs(vel.x - target_speed) / walkspeed)
	sprite_dir_loop()
	if is_on_floor():
		if vel.x == 0:
			anim_switch("idle")
		else:
			anim_switch("walk")
		if Input.is_action_pressed("jump_button"):
			vel.y -= jumpSpeed
			anim_switch("jump")
		if Input.is_action_pressed("down_button"):
			self.position.y += 5
	vel.y += gravity * delta
	vel = move_and_slide(vel, Vector2(0, -1))
	light_loop()
	enter_loop()
	item_loop()


func sprite_dir_loop():
	if vel.x > 0:
		sprite_dir = "right"
	elif vel.x < 0:
		sprite_dir = "left"

func light_loop():
	var mouse = get_global_mouse_position()
	get_node("light_cone").look_at(mouse)

func enter_loop():
	if can_enter and Input.is_action_pressed("door"):
		level.get_parent().switch_scene()

func item_loop():
	if Input.is_action_just_pressed("collect"):
		if current_item != null:
			drop_item()
		elif not items_in_range.empty():
			pickup_item()
			
	#drop cat if yarn is reached
	if current_item != null && current_item.type == "cat":
		for range_item in items_in_range:
			if range_item.type == "yarn":
				drop_item()

func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

func update_inventory_sprite():
	var item_sprite = level.get_node("Inventory").get_node("item_sprite")
	if current_item == null:
		delete_children(item_sprite)
	else:
		var item_scene = load("res://Scenes/Items/item_" + current_item.type + ".tscn").instance()
		item_sprite.add_child(item_scene)
		if current_item.type == "cat":
			item_sprite.scale.x = 0.5
			item_sprite.scale.y = 0.5
		else:
			item_sprite.scale.x = 1
			item_sprite.scale.y = 1

func pickup_item():
	#breakpoint
	var item = items_in_range.pop_front()
	current_item = item
	get_parent().remove_child(item)
	update_inventory_sprite()
	item_effects()
	#print("picked item: " + current_item)

func drop_item():
	#print("dropping item: " + current_item)
	#var spawn_item = item.instance()
	#spawn_item.init(current_item)
	current_item.set_position(Vector2(self.get_position().x, self.get_position().y - 100))
	get_parent().add_child(current_item)
	current_item = null
	update_inventory_sprite()
	item_effects()

# sets the current item's effect:
func item_effects():
	if current_item != null:
		if current_item.type.begins_with("vase"):
			jumpSpeed = 0
		else:
			match current_item.type:
				"cat":
					drop_timer.start(rand_range(5.0, 10.0))
				"coffee":
					walkspeed = 800
					get_node("AnimationPlayer").set_speed_scale(2.0)
				"glasses":
					level.adjust_light(Color(0.2,0.2,0.2,1))
				"vase": 
					jumpSpeed = 0
				"radio":
					get_node("RadioCommPlayer").play()
				"echolocator":
					level.start_echolocate()
				"spring_shoes":
					jumpSpeed = 1200
				"walking_aid":
					walkspeed = 200
					get_node("AnimationPlayer").set_speed_scale(0.5)
	else:
		walkspeed = 400
		get_node("AnimationPlayer").set_speed_scale(1.0)
		drop_timer.stop()
		level.adjust_light(Color.black)
		jumpSpeed = 800
		get_node("RadioCommPlayer").stop()
		level.stop_echolocate()


func item_in_range(item):
	items_in_range.append(item)

func item_out_of_range(item):
	items_in_range.erase(item)
