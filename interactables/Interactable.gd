class_name Interactable extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.interacting.append(self)
		

func _on_body_exited(body):
	if body.is_in_group("player"):
		body.interacting.erase(self)

func interact(player):
	pass
