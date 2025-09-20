class_name Interactable extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Player can interact with chest!")
		# Add a prompt, like an exclamation mark, over the player's head.

func _on_body_exited(body):
	if body.is_in_group("player"):
		print("Player exited interaction area.")
		# Hide the prompt.


func _unhandled_input(event):
	if Input.is_action_just_pressed("interact") and overlaps_body(get_node_or_null("/root/MainScene/Player")):
		# Get a reference to your player node.
		# Check if the player is currently overlapping the Area2D.
		print("FOlder interacted with!")
		# Add your interaction code here (e.g., play animation, open menu).
