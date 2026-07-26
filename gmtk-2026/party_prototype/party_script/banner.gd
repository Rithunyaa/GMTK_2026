extends Area2D

@export var banner_color: String = "purple"

@export var red_texture: Texture2D
@export var blue_texture: Texture2D
@export var pink_texture: Texture2D
@export var purple_texture: Texture2D

var connected = false

func _ready():
	input_event.connect(_on_input_event)
	update_texture()


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if not connected:
				print("Clicked banner: ", banner_color)

func update_texture():
	if banner_color == "red":
		$Sprite2D.texture = red_texture
	
	elif banner_color == "blue":
		$Sprite2D.texture = blue_texture
	
	elif banner_color == "purple":
		$Sprite2D.texture = purple_texture
	
	elif banner_color == "pink":
		$Sprite2D.texture = pink_texture

func lock():
	connected = true
