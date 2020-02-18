extends Position2D

var foo : String = "bar"

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print('checkpoint entered')
		get_node("../Spawn").position = position
