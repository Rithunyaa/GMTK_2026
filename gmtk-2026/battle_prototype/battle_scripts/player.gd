extends CharacterBody2D

# Player movement speed
@export var speed: float = 200.0


func _physics_process(delta):
	var direction = Vector2.ZERO

	# WASD movement
	if Input.is_action_pressed("walk_right"):
		direction.x += 10

	if Input.is_action_pressed("walk_left"):
		direction.x -= 10
		

	if Input.is_action_pressed("walk_down"):
		direction.y += 10
		

	if Input.is_action_pressed("walk_up"):
		direction.y -= 10
		

	# Prevent faster diagonal movement
	if direction.length() > 0:
		direction = direction.normalized()

	# Apply movement
	velocity = direction * speed

	move_and_slide()
