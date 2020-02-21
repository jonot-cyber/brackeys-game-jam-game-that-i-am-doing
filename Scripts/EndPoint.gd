extends Area2D

onready var isHTML = OS.get_name() == "HTML5"
onready var timer : Timer = get_node('../Player/Time/Second')

func _ready():
	timer.one_shot = true

func _on_EndPoint_body_entered(body):
	if body.name == "Player":
		if isHTML:
			JavaScript.eval('alert("if you would like to save your score, download the game")')
		else:
			var save_game = File.new()
			var record = int(save_game.get_as_text())
			if save_game.file_exists("user://savegame.save"):
				save_game.open("user://savegame.save",File.READ_WRITE)
				if int(timer.get_parent().text) < record:
					save_game.store_line(timer.get_parent().text)
					save_game.close()
				else:
					print("slower")
			else:
				save_game.open("user://savegame.save",File.WRITE)
				save_game.store_line(timer.get_parent().text)
				save_game.close()
