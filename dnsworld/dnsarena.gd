extends Node2D


func _ready():
	await $Player.promptDialogue([
		"[b]DNS: [/b] You finally reached me... of course you did.",
		"[b]DNS: [/b] You humans are filled with so much... [b]DETERMINATION.[/b] ",
		"[b]DNS: [/b] It doesn't matter what the risks are... you are too stubborn to see what a grave mistake this is.",
		"[b]DNS: [/b] Please... I [b]BEG[/b] of you... turn back now- you are going to doom us all.",
		"[b]DNS: [/b] You have made it this far already... Anything I say to you is not going to change your mind is it?",
		"[b]DNS: [/b] You're gonna have to get that website out of my cold, dead, hard drive."
	])
	$DNS.start()
