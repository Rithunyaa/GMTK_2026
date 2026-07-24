extends Area2D

var player_near = false


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			start_laundry_task()


func start_laundry_task():
	await get_parent().get_node("DarkScreen").darker()
	get_tree().change_scene_to_file("res://party_prototype/party_scenes/chips_level.tscn")
