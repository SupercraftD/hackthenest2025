extends Panel

@export var label : RichTextLabel
@export var button : Button

func showDialogue(tree):
	visible = true
	for msg in tree:
		
		label.text = ""
		var i = 0
		while i < len(msg):
			label.text += msg[i]
			
			if msg[i] == "[":
				while msg[i]!="]":
					i+=1
					label.text+=msg[i]
			i+=1
			if i<len(msg) and msg[i]==" ":
				continue
			await get_tree().create_timer(0.03).timeout
		
		await button.pressed
		
	visible = false
