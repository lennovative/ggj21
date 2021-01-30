extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var vel = Vector2()
var gravity = Globals.GRAVITY
var walkspeed = 400
var jumpSpeed = 600
var acc = 1700
var items_in_range = []
var current_item = null
var item = load("res://Scenes/Item.tscn")
onready var drop_timer = get_node("drop_timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	name = "player"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_input():
	var x_speed = Input.get_action_strength("right_button") - Input.get_action_strength("left_button")
	return x_speed

func _physics_process(delta):
	var target_speed = get_input() * walkspeed
	vel.x = move_toward(vel.x, target_speed, delta * acc)# * abs(vel.x - target_speed) / walkspeed)
	if is_on_floor():
		if Input.is_action_pressed("jump_button"):
			vel.y -= jumpSpeed
		if Input.is_action_pressed("down_button"):
			self.position.y += 5
	vel.y += gravity * delta
	vel = move_and_slide(vel, Vector2(0, -1))
	
	#rotate light
	var mouse = get_global_mouse_position()
	get_node("light_cone").look_at(mouse)
	#item loop
	item_loop()
	
	

func item_loop():
	if Input.is_action_just_pressed("collect"):
		if current_item != null:
			drop_item()			
		elif not items_in_range.empty():
			pickup_item()


func pickup_item():
	var item = items_in_range.pop_front()
	current_item = item.name
	item.queue_free()
	print("item collected")
	item_effects()

func drop_item():
	var spawn_item = item.instance()
	spawn_item.init(current_item)
	spawn_item.set_position(self.get_position())
	get_parent().add_child(spawn_item)
	current_item = null
	item_effects()

# sets the current item's effect:
func item_effects():
	match current_item:
		"cat":
			drop_timer.start(rand_range(5.0, 10.0))
		_:
			#reset efects
			pass

func item_in_range(item):
	items_in_range.append(item)

func item_out_of_range(item):
	items_in_range.erase(item)
