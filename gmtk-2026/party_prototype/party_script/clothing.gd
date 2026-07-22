extends Area2D

signal collected

var dragging = false
var offset = Vector2.ZERO


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				offset = global_position - get_global_mouse_position()
			else:
				dragging = false


func _process(delta):
	if dragging:
		global_position = get_global_mouse_position() + offset
