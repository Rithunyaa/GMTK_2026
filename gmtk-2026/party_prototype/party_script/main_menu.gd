extends Node


var started = false


func _input(event):

	if started:
		return

	# Any keyboard press
	if event is InputEventKey and event.pressed:
		start_game()

	# Any mouse click
	elif event is InputEventMouseButton and event.pressed:
		start_game()



func start_game():

	started = true
	GameTimer.show_intro = true
	get_tree().change_scene_to_file(
		"res://party_prototype/party_scenes/Bedroom.tscn"
	)
