extends Node

export var duration = 0.2
export var frequency = 15
export var amplitude = 16

var priority = 0

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

onready var tween = get_node("ShakeTween")
onready var nodeFrequency = get_node("Frequency")
onready var nodeDuration = get_node("Duration")
onready var camera = get_parent()

signal start

func start():
	nodeDuration.wait_time = duration
	nodeFrequency.wait_time = 1 / float(frequency)
	nodeDuration.start()
	nodeFrequency.start()
	
	_new_shake()

func _new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
	tween.interpolate_property(camera, "offset", camera.offset, rand, nodeFrequency.wait_time, TRANS, EASE)
	tween.start()

func _reset():
	tween.interpolate_property(camera, "offset", camera.offset, Vector2(), nodeFrequency.wait_time, TRANS, EASE)
	tween.start()

func _on_Frequency_timeout():
	_new_shake()
	
func _on_Duration_timeout():
	_reset()
	nodeFrequency.stop()
