extends Label

var time : float = 0

onready var timer : Timer = get_node("Second")

func _on_Second_timeout():
	time += 0.1
	text = str(time)
	timer.start()
