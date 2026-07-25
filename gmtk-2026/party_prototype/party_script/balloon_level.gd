extends Node2D


var completed_balloons = 0
var current_balloon = 0
@onready var timer_label: RichTextLabel = $CanvasLayer/TimerLabel


func _ready():

	$Balloon1.balloon_completed.connect(balloon_done)
	$Balloon2.balloon_completed.connect(balloon_done)
	$Balloon3.balloon_completed.connect(balloon_done)
	$Balloon1.set_process(true)
	$Balloon2.set_process(false)
	$Balloon3.set_process(false)
	update_timer()
	GameTimer.time_updated.connect(update_timer)



func balloon_done():

	if current_balloon == 0:
		$Balloon1.set_process(false)
		current_balloon = 1
		$Balloon2.set_process(true)

	elif current_balloon == 1:
		$Balloon2.set_process(false)
		current_balloon = 2
		$Balloon3.set_process(true)

	else:
		$Balloon3.set_process(false)
		finish_task()



func finish_task():

	print("All balloons finished!")

	get_tree().change_scene_to_file(
		"res://party_prototype/party_scenes/Bedroom.tscn"
	)
	
func update_timer():
	timer_label.text = "[shake level=6]Party starts in: " + GameTimer.get_time_text()
