extends CanvasLayer

@onready var animation = $Animation

func _ready():
	visible = true
	brighter()

## fade out
func darker():
	animation.play("darker")
	await animation.current_animation_changed

## fade in
func brighter():
	animation.play_backwards("darker")
	await animation.current_animation_changed
	visible = false
