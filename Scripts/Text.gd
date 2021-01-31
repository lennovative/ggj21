extends Control

func _on_Area2D_body_entered(body):
	if body.name == "player":
		self.visible = true
		body.can_enter = true

func _on_Area2D_body_exited(body):
	if body.name == "player":
		self.visible = false
		body.can_enter = false
