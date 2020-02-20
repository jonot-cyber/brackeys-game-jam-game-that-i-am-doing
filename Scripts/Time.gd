extends Label

var time : float = 0

func _on_Second_timeout():
	time += 0.1
	text = str(time)
