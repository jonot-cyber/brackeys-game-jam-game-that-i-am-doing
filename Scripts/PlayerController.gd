extends KinematicBody2D

var direction      : Vector2 = Vector2(0,0)

export var speed   : float = 5
export var gravity : float = .1

onready var camera : Camera2D = get_node("Camera")

signal switch

var dragState
var last_collision
var can_jump = true

func _ready():
	reset()
	camera.current = true

func _process(_delta):
	if dragState and can_jump:
			can_jump = false
			direction.x = get_local_mouse_position().normalized().x * speed
			direction.y = get_local_mouse_position().normalized().y * speed
	direction.y += gravity

	direction.y = clamp(direction.y,-5,5)
	if direction.x < 0:
		$Sprite.set_flip_h(true)
	elif direction.x > 0:
		$Sprite.set_flip_h(false)

	
func _physics_process(_delta):
	var collision = move_and_collide(direction * speed)
	if collision:
		can_jump = true
		if last_collision != collision.collider_id:
			direction = Vector2(0,0)
		last_collision = collision.collider_id
	else:
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
