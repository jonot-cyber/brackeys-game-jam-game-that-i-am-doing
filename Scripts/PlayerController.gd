extends KinematicBody2D

var direction      : Vector2 = Vector2(0,0)

export var speed   : float = 5
export var gravity : float = .1

onready var camera : Camera2D = get_node("Camera")
onready var sprite : Sprite   = get_node("Sprite")

onready var shake  := camera.get_node("ScreenShake")

onready var jump   : AudioStreamPlayer2D = get_node("Jump")
onready var land   : AudioStreamPlayer2D = get_node("Land")

signal switch
signal reset

var dragState

var last_collision
var can_jump = true

var collision

func _ready():
	reset()
	camera.current = true

func _process(_delta):
	if position.y > 3000:
		reset()
		get_node('..').active = 'red'
		emit_signal('reset')
	if dragState and can_jump:
		if not jump.playing:
			jump.play()
		shake.start(0.1, 7.5, 8)
		can_jump = false
		direction.x = get_local_mouse_position().normalized().x * speed
		direction.y = get_local_mouse_position().normalized().y * speed
	direction.y += gravity

	direction.y = clamp(direction.y,-50,5)
	if direction.x < 0:
		sprite.set_flip_h(true)
	elif direction.x > 0:
		sprite.set_flip_h(false)

	
func _physics_process(_delta):
	collision = move_and_collide(direction * speed)
	if collision:
		can_jump = true
		if last_collision != collision.collider_id:
			if not land.playing:
				land.play()
			shake.start(0.2, 15, 16)
			direction = Vector2(0,0)
		last_collision = collision.collider_id
	else:
		can_jump = false
		last_collision = 0

func reset():
	direction = Vector2(0,0)
	position = get_node("../Spawn").position

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if not dragState:
			dragState = true
		else:
			dragState = false
	elif event is InputEventKey and event.pressed and event.scancode == KEY_SPACE:
		emit_signal('switch')
