extends Label

func _ready():
	var save = File.new()
	
	if save.file_exists("user://savegame.save"):
		var string = "Best Time: %s seconds"
		save.open("user://savegame.save",File.READ)
		text = string % str(save.get_line())
	else:
		visible = false
