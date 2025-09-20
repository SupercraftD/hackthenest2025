extends Interactable
func interact(player):
	player.promptDialogue([
		"The portal seems to be a way out. It is the only way to move forward."
		])
	get_tree().change_scene_to_file("res://firewallfight/firearena.tscn")
