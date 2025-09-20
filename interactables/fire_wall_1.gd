extends Interactable

func interact(player):
	player.promptDialogue([
		"The Firewall regulates internet traffic, checking for malicious IPs","It ensures no bad data gets in.","Bad data like [b]you.[/b]"
		])
