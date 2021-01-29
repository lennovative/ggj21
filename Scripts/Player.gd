extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var vel = Vector2()
var gravity = 1200
var walkspeed = 400
var jumpSpeed = 600
var acc = 1700


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
			self.position.y += 10
	vel.y += gravity * delta
	vel = move_and_slide(vel, Vector2(0, -1))
