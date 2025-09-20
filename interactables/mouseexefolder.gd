extends Interactable

func interact(player):
	
	await player.promptDialogue([
		"You find a MOUSE CURSOR in the folder"
	])
	
