extends Node

signal time_updated
signal time_finished
var show_intro = false
var game_active = false

const LIMITED_TIME = 40.0
var time_left = LIMITED_TIME
var running = true
var previous_scene: String = ""
var party_ready = false
var laundry_done = false
var chips_done = false
var balloons_done = false
var banners_done = false
var game_over = false
var time_used:float = 0


func _process(delta):
	if not running:
		return

	time_left -= delta

	if time_left <= 0 and !game_over:
		game_over = true
		time_left = 0
		running = false

		get_tree().change_scene_to_file(
			"res://party_prototype/party_scenes/ending.tscn"
		)

	time_updated.emit()
	
	if GameTimer.laundry_done \
	and GameTimer.chips_done \
	and GameTimer.balloons_done \
	and GameTimer.banners_done \
	and not time_used:
		time_used = LIMITED_TIME - time_left


func get_time_text():
	var minutes = int(time_left) / 60
	var seconds = int(time_left) % 60

	return "%02d:%02d" % [
		minutes,
		seconds
	]

func reset_timer():
		time_left = LIMITED_TIME
		running = true
		game_over = false
		GameTimer.laundry_done = false
		GameTimer.chips_done = false
		GameTimer.balloons_done = false
		GameTimer.banners_done = false
