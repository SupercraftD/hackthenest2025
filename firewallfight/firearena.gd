extends Node2D

var geysers = []

func _ready():
	$fireWall.modulate.a = 0
	await $Player.promptDialogue([
		"Look! there's the exit!"
	])
	await get_tree().create_tween().tween_property($fireWall,"modulate:a",1,1).finished
	var child_node = get_node("Player/Camera2D")
	child_node.start_shake(8.0, 2.0)
	await $Player.promptDialogue([
		"[center][b]Firewall: [/b]you... shall... not... PASS!!"
	])
	$fireWall.start()
	$fireWall.dead.connect(done)
	
func done():
	for i in geysers:
		if i != null:
			i.queue_free()
