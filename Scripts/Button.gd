extends Button

func press():
	print(text)
	if name == "Play":
		get_tree().change_scene("res://Scenes/Game.tscn")
	elif name == "Credits":
		get_tree().change_scene("res://Scenes/Credits.tscn")
	elif name == "Instructions":
		get_tree().change_scene("res://Scenes/Instructions.tscn")
