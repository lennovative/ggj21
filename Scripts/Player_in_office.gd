extends KinematicBody2D

var vel = Vector2()
var gravity = Globals.GRAVITY
var walkspeed = 430
var acc = 1700
var sprite_dir = "left"
var can_enter = false
var can_deliver = false
var room_size = 1920 * 2

# Called when the node enters the scene tree for the first time.
func _ready():
	name = "player"
	if get_node("/root/Game").first_scene:
		self.position.x = room_size - 400

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
	get_parent().get_node("Camera2D").update_camera(self.position.x)
	enter_loop()
	exit_loop()

func enter_loop():
	if can_enter and Input.is_action_just_pressed("door"):
		get_parent().get_parent().switch_scene()

func deliver_loop():
	if can_deliver and Input.is_action_just_pressed("deliver"):
		get_parent().get_parent().item_deliver()

func sprite_dir_loop():
	if vel.x > 0:
		sprite_dir = "right"
	elif vel.x < 0:
		sprite_dir = "left"

func exit_loop():
	if position.x > room_size + 220:
		print("exit")
		get_tree().queue_delete(get_tree())
		get_tree().quit()
