extends KinematicBody2D

var vel = Vector2()
var gravity = Globals.GRAVITY
var walkspeed = 400
var acc = 1700
var sprite_dir = "right"

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
	anim_switch("idle" if vel.x == 0 else "walk")
	vel.y += gravity * delta
	vel = move_and_slide(vel, Vector2(0, -1))

func sprite_dir_loop():
	if vel.x > 0:
		sprite_dir = "right"
	elif vel.x < 0:
		sprite_dir = "left"
