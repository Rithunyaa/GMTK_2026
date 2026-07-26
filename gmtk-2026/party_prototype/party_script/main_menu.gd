extends Node


var started = false
var music = preload("res://party_prototype/party_scenes/music.tscn")


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
	#add Music Node
	get_parent().add_child(music.instantiate())

	started = true
	GameTimer.show_intro = true
	GameTimer.previous_scene = "main_menu"
	get_tree().change_scene_to_file(
		"res://party_prototype/party_scenes/Bedroom.tscn"
	)
