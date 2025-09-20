extends Interactable

func interact(player):
	
	await player.promptDialogue([
		"You find mouse.exe in the folder","press space or left-click to fire a cursor"
	])
	
