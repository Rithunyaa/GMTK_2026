extends Area2D

signal collected

var dragging = false
var offset = Vector2.ZERO

@onready var pickup_sound: AudioStreamPlayer2D = $PickUpSound
@onready var drop_sound: AudioStreamPlayer2D = $DropSound


@warning_ignore("unused_parameter")
func _process(delta):
	if dragging:
		var mouse_position = get_global_mouse_position()

		var screen_size = get_viewport_rect().size

		mouse_position.x = clamp(mouse_position.x, 0, screen_size.x)
		mouse_position.y = clamp(mouse_position.y, 0, screen_size.y)

		global_position = mouse_position + offset


@warning_ignore("unused_parameter")
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:

		if event.pressed:
			dragging = true
			offset = global_position - get_global_mouse_position()
			move_to_front()

			pickup_sound.play()

			get_viewport().set_input_as_handled()

		else:
			dragging = false

			# Play place/drop sound wherever it is dropped
			drop_sound.play()


func _on_body_entered(body):
	if body.name == "LaundryBasket":
		collected.emit()
		queue_free()
