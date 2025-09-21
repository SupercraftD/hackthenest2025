extends Interactable

func interact(player):
	await player.promptDialogue([
		"The portal seems to be a way out. It is the only way to move forward."
		])
	await create_tween().tween_property(get_parent().get_node("CanvasLayer/Panel"),"modulate:a",1,1).finished
	
	get_tree().change_scene_to_file("res://dnsworld/dnsarena.tscn")
