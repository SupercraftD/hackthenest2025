extends Node2D


func _ready():
	await $Player.promptDialogue([
		"[b]DNS: [/b]You finally reached me... But you won't get past my filter!"
	])
	$DNS.start()
