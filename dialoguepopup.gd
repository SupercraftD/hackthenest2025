extends Panel

@export var label : RichTextLabel
@export var button : Button

func showDialogue(tree):
	for msg in tree:
		
		label.text = ""
		var i = 0
		while i < len(msg):
			label.text += msg[i]

			if msg[i] == "[":
				while msg[i]!="]":
					label.text+=msg[i]
					i+=1
			i+=1
			await get_tree().create_timer(0.1).timeout
		
		
