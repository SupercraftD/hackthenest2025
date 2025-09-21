extends Interactable

func interact(player):
	
	if "mouse" in GameInfo.availableWeapons:
		await player.promptDialogue([
			"This folder is empty..."
		])
	else:
		await player.promptDialogue([
			"You find mouse.exe in the folder","press space or left-click to fire a cursor"
		])
		GameInfo.availableWeapons.append("mouse")
		GameInfo.weapon += 1
	
