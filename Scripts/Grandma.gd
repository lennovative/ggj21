extends Sprite

var text_nice = "Very nice!"
var text_wrong = "I don't need this!"
var text_no_item = "Hurry up!"

func speak(type):
	if type == "no_item":
		$Speak.get_node("Label").text = text_no_item
	elif type == "wrong":
		$Speak.get_node("Label").text = text_wrong
	elif type == "nice":
		$Speak.get_node("Label").text = text_nice
	$Speak.get_node("Label").visible = true
	$Timer.start()
	$AnimationPlayer.play("speak")


func _on_Timer_timeout():
	$Speak.get_node("Label").visible = false
