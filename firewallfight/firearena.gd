extends Node2D

func _ready():
	$fireWall.modulate.a = 0
	await $Player.promptDialogue([
		"Look! there's the exit!"
	])
	await get_tree().create_tween().tween_property($fireWall,"modulate:a",1,1).finished
	await $Player.promptDialogue([
		"[center][b]Firewall: [/b]you... shall... not... PASS!!"
	])
	$fireWall.start()
