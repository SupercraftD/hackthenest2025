extends Control


func _on_clickbutton_pressed() -> void:
	$popup1.visible = true
	$clickbutton.disabled = true

func _on_button_1_pressed() -> void:
	$popup1/Button1.disabled = true
	$popup2.visible = true

func _on_button_2_pressed() -> void:
	$popup2/Button2.disabled = true
	$popup3.visible = true


func _on_button_3_pressed() -> void:
	$popup3/Button3.disabled = true
	$popup4.visible = true


func _on_button_4_pressed() -> void:
	await create_tween().tween_property($Panel,"modulate:a",1,1).finished
	get_tree().change_scene_to_file("res://world.tscn")
