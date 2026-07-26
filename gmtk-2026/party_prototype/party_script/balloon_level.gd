extends Node2D


var completed_balloons = 0
var current_balloon = 0
@onready var timer_label: RichTextLabel = $CanvasLayer/TimerLabel
@onready var balloon_sound: AudioStreamPlayer2D = $Balloon_sound


func _ready():

	$Balloon1.balloon_completed.connect(balloon_done)
	$Balloon2.balloon_completed.connect(balloon_done)
	$Balloon3.balloon_completed.connect(balloon_done)
	$Balloon1.set_process(true)
	$Balloon2.set_process(false)
	$Balloon3.set_process(false)
	update_timer()
	GameTimer.time_updated.connect(update_timer)
	
	GameTimer.previous_scene = "balloon_task"



func balloon_done():

	if current_balloon == 0:
		$Balloon1.set_process(false)
		current_balloon = 1
		$Balloon2.set_process(true)
		balloon_sound.play()

	elif current_balloon == 1:
		$Balloon2.set_process(false)
		current_balloon = 2
		$Balloon3.set_process(true)
		balloon_sound.play()

	else:
		$Balloon3.set_process(false)
		balloon_sound.play()
		finish_task()



func finish_task():

	print("All balloons finished!")
	GameTimer.balloons_done = true
	$Tick.show()
	await $DarkScreen.darker()
	get_tree().change_scene_to_file(
		"res://party_prototype/party_scenes/living_room.tscn"
	)
	
func update_timer():
	timer_label.text = "[shake level=6]Party starts in: " + GameTimer.get_time_text()
