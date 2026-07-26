extends Area2D

var player_near = false


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			start_banner_task()


func start_banner_task():
	await get_parent().get_node("DarkScreen").darker()
	get_tree().change_scene_to_file("res://party_prototype/party_scenes/banner_level.tscn")
