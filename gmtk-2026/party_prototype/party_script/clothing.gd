extends Area2D

@warning_ignore("unused_signal")
signal collected

@onready var sprite = $Sprite2D

var dragging = false
var offset = Vector2.ZERO


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				offset = global_position - get_global_mouse_position()
				move_to_front()
			else:
				dragging = false


@warning_ignore("unused_parameter")
func _process(delta):
	if dragging:
		var mouse_position = get_global_mouse_position()

		var screen_size = get_viewport_rect().size

		mouse_position.x = clamp(mouse_position.x, 0, screen_size.x)
		mouse_position.y = clamp(mouse_position.y, 0, screen_size.y)

		global_position = mouse_position + offset
