extends Position2D

export var color : Color

signal checkpoint

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_node("../Spawn").position = position
		get_node("../Player/Background").modulate = color
		emit_signal("checkpoint")
