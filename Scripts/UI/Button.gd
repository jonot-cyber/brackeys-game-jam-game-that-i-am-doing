extends Button

func press():
	get_tree().change_scene("res://Scenes/" + name + ".tscn")
