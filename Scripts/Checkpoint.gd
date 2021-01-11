extends Position2D

export var color : Color
export var duration : float = 1
export var switch : String = "red"

onready var tween      := get_node("Tween")
onready var background := get_node("../../Player/Background")
onready var spawn      := get_node("../../Spawn")
onready var player     := get_node("../../Player")

onready var main    := get_node("../..")
onready var tilemap := get_node("../../TileMap")

const TRANS = Tween.TRANS_LINEAR
const EASE  = Tween.EASE_IN_OUT

signal checkpoint

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		spawn.position = position
		player._on_checkpoint()
		main.active = switch
		tween.interpolate_property(background, "color", background.color, color, duration, TRANS, EASE)
		tween.start()
		emit_signal("checkpoint")
