extends Node

signal time_updated
signal time_finished

var time_left = 30.0
var running = true


func _process(delta):
	if not running:
		return

	time_left -= delta

	if time_left <= 0:
		time_left = 0
		running = false
		time_finished.emit()

	time_updated.emit()


func get_time_text():
	var minutes = int(time_left) / 60
	var seconds = int(time_left) % 60

	return "%02d:%02d" % [
		minutes,
		seconds
	]
