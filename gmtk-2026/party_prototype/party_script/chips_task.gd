extends Area2D

var player_near = false
@onready var instructions: RichTextLabel = $"../CanvasLayer/Instructions"

func _ready():
	$Sprite2D.visible = not GameTimer.chips_done


#func _input_event(_viewport, event, _shape_idx):
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#start_chips_task()

func _process(_delta):
	for body in get_overlapping_bodies():
		if body.name == "Player" and Input.is_action_just_pressed("interact"):
			start_chips_task()


func start_chips_task():
	if not GameTimer.chips_done:
		await get_parent().get_node("DarkScreen").darker()
		instructions.visible = false
		get_tree().change_scene_to_file("res://party_prototype/party_scenes/chips_level.tscn")
