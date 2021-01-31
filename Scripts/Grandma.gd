extends Sprite

var text_nice = "There it is! I've been looking for that thing since ages! I left a few more requests at your bulletin. Call me, once you found something else that's mine."
var text_wrong = "... What is that? That's not mine... Did you really summon an old lady all the way out here to mess with her??? That's mean! Call me, when you find something that -actually- belongs to me."
var text_no_item = "What's up, hun? Don't you know what to do? I left a few requests at the bulletin. Just look, if you can find some of it somewhere in the storage. Remember to take your flashlight, it's dark out there. Collect items by pressing E."

func speak(type):
	if type == "no_item":
		$Speak.get_node("Label").text = text_no_item
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
