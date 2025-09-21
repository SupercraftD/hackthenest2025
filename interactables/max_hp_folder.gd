extends Interactable

func interact(player):
	
	if GameInfo.playerHp>=15:
		await player.promptDialogue([
			"This folder is empty..."
		])
	else:
		await player.promptDialogue([
			"You've fought a lot of enemies!","Your max HP has now been buffed to 15.","Good luck with your journey to the website", " -A 3rd party hacker"
		])
		GameInfo.playerHp = 15
	
