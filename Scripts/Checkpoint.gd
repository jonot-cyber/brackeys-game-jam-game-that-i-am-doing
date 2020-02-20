extends Position2D

export var color : Color
export var duration : float = 1

onready var tween      : Tween =           get_node("Tween")
onready var background : Sprite =          get_node("../Player/Background")
onready var spawn      : Position2D =      get_node("../Spawn")
onready var player     : KinematicBody2D = get_node("../Player")

const TRANS = Tween.TRANS_LINEAR
const EASE = Tween.EASE_IN_OUT

signal checkpoint

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		spawn.position = position
		player._on_checkpoint()
		tween.interpolate_property(background, "modulate", background.modulate, color, duration, TRANS, EASE)
		tween.start()
		emit_signal("checkpoint")
