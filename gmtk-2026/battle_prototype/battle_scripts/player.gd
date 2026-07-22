extends CharacterBody2D

# Player movement speed
@export var speed: float = 200.0


func _physics_process(delta):
	var direction = Vector2.ZERO

	# WASD movement
	if Input.is_action_pressed("walk_right"):
		direction.x += 10
		print("right")

	if Input.is_action_pressed("walk_left"):
		direction.x -= 10
		print("left")

	if Input.is_action_pressed("walk_down"):
		direction.y += 10
		print("up")

	if Input.is_action_pressed("walk_up"):
		direction.y -= 10
		print("down")

	# Prevent faster diagonal movement
	if direction.length() > 0:
		direction = direction.normalized()

	# Apply movement
	velocity = direction * speed

	move_and_slide()
