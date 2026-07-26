extends Node2D

@onready var timer_label: RichTextLabel = $CanvasLayer/TimerLabel
@onready var finished_balloons: Sprite2D = $Finished_Balloons
@onready var finished_banner: Sprite2D = $Finished_Banner
@onready var finished_bowl:Sprite2D = $Finished_Bowl
@onready var banner_taskpoint: Area2D = $BannerTask
@onready var balloon_taskpoint: Area2D = $BalloonTask

@onready var instructions_text: RichTextLabel = $CanvasLayer/Instructions


func _ready():

	update_timer()
	GameTimer.time_updated.connect(update_timer)

	#spawn layer correctly
	var player := $Player
	
	match GameTimer.previous_scene:
		
		"hallway":
			player.position = Vector2(516,1192)
	
	GameTimer.previous_scene = "living_room"

	finished_balloons.visible = GameTimer.balloons_done
	finished_banner.visible = GameTimer.banners_done
	finished_bowl.visible = GameTimer.chips_done

	balloon_taskpoint.visible = not GameTimer.balloons_done
	banner_taskpoint.visible = not GameTimer.banners_done


	# Instructions
	if GameTimer.balloons_done and GameTimer.banners_done:

		instructions_text.visible = false

	else:

		instructions_text.text = "Click any object highlighted white"
		instructions_text.visible = true

func update_timer():
	timer_label.text = "[shake level=6]Party starts in: " + GameTimer.get_time_text()
