extends Node2D

@onready var player = $"../../Player"
const SCALE = 0.367

func shoot():
	for pivot in get_children():
		pivot.look_at(player.global_position)
		await get_tree().create_timer(1.2).timeout
		pivot.get_node("laser").visible = true
		pivot.get_node("laser").get_node("Area2D").get_node("CollisionShape2D").disabled = false
		var tween = create_tween()
		tween.tween_property(pivot.get_node("laser"), "scale:y", 0, 1)
		await tween.finished
		pivot.get_node("laser").scale.y = SCALE
		pivot.get_node("laser").visible = false
		pivot.get_node("laser").get_node("Area2D").get_node("CollisionShape2D").disabled = true
