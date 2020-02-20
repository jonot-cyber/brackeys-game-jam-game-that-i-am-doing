extends Node2D

export var active = "red"

func _ready():
	Engine.target_fps = 60

func _on_Player_switch():
	if active == "red":
		active = "blue"
	else:
		active = "red"
