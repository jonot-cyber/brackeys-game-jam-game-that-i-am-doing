extends KinematicBody2D

var direction = Vector2(0,0)
export var speed = 5
export var gravity = .1

func _process(_delta):
	direction.x = 0
	if Input.is_key_pressed(KEY_A):
		direction.x -= 1
	elif Input.is_key_pressed(KEY_D):
		direction.x += 1
	direction.y += gravity
	direction.y = clamp(direction.y,0,5)
	if direction.x < 0:
		$Sprite.set_flip_h(true)
	elif direction.x > 0:
		$Sprite.set_flip_h(false)
	
func _physics_process(_delta):
	move_and_collide(direction * speed)
