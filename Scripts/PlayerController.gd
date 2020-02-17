extends KinematicBody2D

var direction = Vector2(0,0)

export var speed   : float = 5
export var gravity : float = .1

onready var camera = get_node("Camera")

var mousePosition
var dragState

func _ready():
	reset()
	camera.current = true

func _process(_delta):
	if dragState and direction.y == 5:
			direction.x = get_local_mouse_position().normalized().x * speed
			direction.y = get_local_mouse_position().normalized().y * speed
	direction.y += gravity
	direction.y = clamp(direction.y,-5,5)
	
func _physics_process(_delta):
	move_and_collide(direction * speed)

func reset():
	direction = Vector2(0,0)
	position = get_node("../Spawn").position

func _input(event):
    if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
        if not dragState:
            dragState = true
        else:
            dragState = false