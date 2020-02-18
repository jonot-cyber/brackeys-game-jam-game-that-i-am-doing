extends Position2D

var foo : String = "bar"
signal checkpoint

func _on_Area2D_body_entered(body):
	print("d")
	if body.name == "Player":
		print('checkpoint entered')
		get_node("../Spawn").position = position
		emit_signal("checkpoint")
