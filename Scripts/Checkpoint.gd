extends Position2D

var foo : String = "bar"
signal checkpoint

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_node("../Spawn").position = position
		emit_signal("checkpoint")
