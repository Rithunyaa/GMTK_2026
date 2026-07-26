extends Area2D

var player_near = false
@onready var instructions: RichTextLabel = $"../CanvasLayer/Instructions"

func _ready():
	$Sprite2D.visible = not GameTimer.chips_done


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			start_laundry_task()


func start_laundry_task():
	if not GameTimer.chips_done:
		await get_parent().get_node("DarkScreen").darker()
		instructions.visible = false
		get_tree().change_scene_to_file("res://party_prototype/party_scenes/chips_level.tscn")
