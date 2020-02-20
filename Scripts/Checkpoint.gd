extends Position2D

export var color : Color
export var duration : float = 1

onready var tween : Tween = get_node("Tween")
onready var background : Sprite = get_node("../Player/Background")

signal checkpoint

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_node("../Spawn").position = position
		get_node("../Player")._on_checkpoint()
		print(modulate)
		tween.interpolate_property(background, "modulate", background.modulate, color, duration, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tween.start()
		emit_signal("checkpoint")
