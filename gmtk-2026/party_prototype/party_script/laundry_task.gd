extends Area2D

var player_near = false
@onready var instructions: RichTextLabel = $"../CanvasLayer/RichTextLabel"


func _ready():
	$InteractibleArea.body_entered.connect(_on_player_entered)
	$InteractibleArea.body_exited.connect(_on_player_exited)
	
	if GameTimer.laundry_done:
		$Sprite2D.frame = 1


func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		print("E PRESSED")

	if player_near and Input.is_action_just_pressed("interact"):
		start_laundry_task()


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			start_laundry_task()


func _on_player_entered(body):
	print("PLAYER ENTERED BASKET AREA")

	if body.name == "Player":
		player_near = true


func _on_player_exited(body):
	print("PLAYER LEFT BASKET AREA")

	if body.name == "Player":
		player_near = false


func start_laundry_task():
	if not GameTimer.laundry_done:
		await get_parent().get_node("DarkScreen").darker()
		instructions.visible = false
		get_tree().change_scene_to_file("res://party_prototype/party_scenes/cleanroom_level.tscn")
