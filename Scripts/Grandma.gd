extends Sprite

const text_nice = "There it is! I've been looking for that thing since ages! I left a few more requests at your bulletin. Call me, once you found something else that's mine."
const text_wrong = "... What is that? That's not mine... Can you go back and make sure, that ~really~ nobody found what I am looking for? Some citizen of Townville must have found it and brought it here... Right?"
const text_no_item = "What's up, hun? Don't you know what to do? I left a few requests at the bulletin. Just look, if you can find some of it somewhere in the storage. Remember to take your flashlight, it's dark out there. Collect items by pressing E."
const text_tutorial = "Oh, hello dear! Good that you are back. I lost my sweet little Snowball! Can you help me find my precious kitty? But be careful, she really ~loves~ to play with yarn. Get items by pressing E."

func speak(type):
	if type == "no_item":
		$Speak.get_node("Label").text = text_tutorial if get_parent().get_parent().first_scene else text_no_item
	elif type == "wrong":
		$Speak.get_node("Label").text = text_wrong
	elif type == "nice":
		$Speak.get_node("Label").text = text_nice
	$Speak.visible = true
	$Timer.start()
	$AnimationPlayer.play("speak")


func _on_Timer_timeout():
	hide_text()

func hide_text():
	$Speak.visible = false
