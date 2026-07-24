extends CharacterBody2D

@export var speed = 200

@onready var animated_sprite = $AnimatedSprite2D
var facing_up = false


@warning_ignore("unused_parameter")
func _physics_process(delta):
	var direction = Vector2.ZERO

	if Input.is_action_pressed("walk_right"):
		direction.x += 1

	if Input.is_action_pressed("walk_left"):
		direction.x -= 1

	if Input.is_action_pressed("walk_down"):
		direction.y += 1

	if Input.is_action_pressed("walk_up"):
		direction.y -= 1

	velocity = direction.normalized() * speed
	move_and_slide()

	update_animation(direction)



func update_animation(direction):
	if direction.y > 0:
		facing_up = false
		animated_sprite.play("walk_down")

	elif direction.y < 0:
		facing_up = true
		animated_sprite.play("walk_up")

	elif direction == Vector2.ZERO:
		if facing_up:
			animated_sprite.play("idle_up")
		else:
			animated_sprite.play("idle_down")
