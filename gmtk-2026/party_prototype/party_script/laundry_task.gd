extends Area2D

var player_near = false


func _ready():
	$InteractibleArea.body_entered.connect(_on_player_entered)
	$InteractibleArea.body_exited.connect(_on_player_exited)


func _process(delta):
	if Input.is_action_just_pressed("interact"):
		print("E PRESSED")

	if player_near and Input.is_action_just_pressed("interact"):
		start_laundry_task()


func _input_event(viewport, event, shape_idx):
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
	await get_parent().get_node("DarkScreen").darker()
	get_tree().change_scene_to_file("res://party_prototype/party_scenes/cleanroom_level.tscn")
