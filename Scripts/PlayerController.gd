extends KinematicBody2D

var direction = Vector2(0,0)

export var speed = 5
export var gravity = .1

onready var camera = get_node("Camera")

func _ready():
	camera.current = true

func _process(_delta):
	direction.x = 0
	if Input.is_key_pressed(KEY_A):
		direction.x -= 1
	elif Input.is_key_pressed(KEY_D):
		direction.x += 1
	direction.y += gravity
	direction.y = clamp(direction.y,0,5)
	
func _physics_process(_delta):
	move_and_collide(direction * speed)
