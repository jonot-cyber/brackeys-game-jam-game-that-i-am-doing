extends KinematicBody2D

var direction      : Vector2 = Vector2(0,0)

export var speed   : float = 5
export var gravity : float = .1

onready var camera : Camera2D = get_node("Camera")
onready var sprite : Sprite   = get_node("Sprite")

onready var shake  := camera.get_node("ScreenShake")

onready var jump         : AudioStreamPlayer2D = get_node("Music/Jump")
onready var land         : AudioStreamPlayer2D = get_node("Music/Land")
onready var explosion    : AudioStreamPlayer2D = get_node("Music/Explosion")
onready var checkpoint   : AudioStreamPlayer2D = get_node("Music/Checkpoint")

onready var particles    : CPUParticles2D = get_node("Particles")
onready var bounce       : CPUParticles2D = get_node("Bounce")

onready var bounce_timer : Timer = get_node("Bounce/BounceTimer")

onready var respawn      : Timer = get_node("Respawn")

signal switch
signal reset

var dragState

var last_collision
var can_jump = true

var can_switch = true
var can_fullscreen = true

var collision

func _ready():
	reset()
	camera.current = true

func _process(_delta):
	if position.y > 3000 and respawn.time_left == 0:
		particles.emitting = true
		shake.start(0.2, 30, 32)
		explosion.play()
		sprite.visible = false
		respawn.start()
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
				bounce.emitting = true
				bounce.restart()
				bounce_timer.start()
			shake.start(0.2, 15, 16)
			direction = Vector2(0,0)
		last_collision = collision.collider_id
	else:
		can_jump = false
		last_collision = 0

func reset():
	direction = Vector2(0,0)
	position = get_node("../Spawn").position

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if not dragState:
			dragState = true
		else:
			dragState = false
	elif event is InputEventKey and event.scancode == KEY_SPACE:
		if event.pressed:
			if can_switch:
				emit_signal('switch')
				can_switch = false
		else:
			can_switch = true
	if event is InputEventKey and event.scancode == KEY_F11:
		if event.pressed:
			if can_fullscreen:
				OS.window_fullscreen = !OS.window_fullscreen
				can_fullscreen = false
		else:
			can_fullscreen = true


func _on_Respawn_timeout():
	reset()
	get_node('..').active = 'red'
	emit_signal('reset')
	sprite.visible = true

func _on_checkpoint():
	checkpoint.play()
	get_node("Label")._on_checkpoint()


func _on_EndPoint_body_entered(body):
	$Win.visible = true

func bounce_timeout():
	bounce.emitting = false


func _on_SwitchButton_pressed():
	emit_signal("switch")
