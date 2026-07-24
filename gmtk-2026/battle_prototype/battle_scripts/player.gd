extends CharacterBody2D

@export var speed = 200

@onready var animated_sprite = $AnimatedSprite2D

enum DIRECTIONS{
	UP,
	DOWN,
	LEFT,
	RIGHT
}
var facing_direction = DIRECTIONS.DOWN

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
		facing_direction = DIRECTIONS.DOWN
		animated_sprite.play("walk_down")

	elif direction.y < 0:
		facing_direction = DIRECTIONS.UP
		animated_sprite.play("walk_up")
	
	elif direction.x > 0:
		facing_direction = DIRECTIONS.RIGHT
		animated_sprite.play("walk_right")
		
	elif direction.x < 0:
		facing_direction = DIRECTIONS.LEFT
		animated_sprite.play("walk_left")

	elif direction == Vector2.ZERO:
		match facing_direction:
			DIRECTIONS.UP:
				animated_sprite.play("idle_up")
			DIRECTIONS.DOWN:
				animated_sprite.play("idle_down")
			DIRECTIONS.LEFT:
				animated_sprite.play("idle_left")
			DIRECTIONS.RIGHT:
				animated_sprite.play("idle_right")
