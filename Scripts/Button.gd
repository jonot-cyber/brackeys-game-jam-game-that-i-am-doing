extends Button

func press():
	print(text)
	if name == "Play":
		get_tree().change_scene("res://Scenes/Game.tscn")
	elif name == "Credits":
		get_tree().change_scene("res://Credits.tscn")
	elif name == "Instructions":
		get_tree().change_scene("res://Instructions.tscn")
