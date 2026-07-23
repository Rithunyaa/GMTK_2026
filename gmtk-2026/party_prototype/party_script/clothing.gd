extends Area2D

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


func _process(_delta):
	if dragging:
		sprite.frame = 1
		global_position = get_global_mouse_position() + offset
	else:
		sprite.frame = 0
