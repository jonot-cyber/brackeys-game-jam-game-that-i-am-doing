extends Area2D

func _ready():
	get_node('../Player/Time/Second')

func _on_EndPoint_body_entered(body):
	if body.name == "Player":
		var timer = get_node('../Player/Time/Second')
		timer.one_shot = true
		if OS.get_name() == "HTML5":
			JavaScript.eval('alert("if you would like to save your score, download the game")')
		else:
			var save_game = File.new()
			var record = int(save_game.get_as_text())
			save_game.open("user://savegame.save",File.READ_WRITE)
			if int(timer.get_parent().text) < record:
				save_game.store_line(timer.get_parent().text)
				save_game.close()
			else:
				print("slower")
