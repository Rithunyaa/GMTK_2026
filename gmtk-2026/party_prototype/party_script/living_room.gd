extends Node2D

@onready var timer_label: RichTextLabel = $CanvasLayer/TimerLabel
@onready var finished_balloons: Sprite2D = $Finished_Balloons
@onready var finished_banner: Sprite2D = $Finished_Banner
@onready var banner_taskpoint: Area2D = $BannerTask
@onready var balloon_taskpoint: Area2D = $BalloonTask



func _ready():
	update_timer()
	GameTimer.time_updated.connect(update_timer)
	finished_balloons.visible = GameTimer.balloons_done
	finished_banner.visible = GameTimer.banners_done
	balloon_taskpoint.visible = not GameTimer.balloons_done
	banner_taskpoint.visible = not GameTimer.banners_done
		
	

func update_timer():
	timer_label.text = "[shake level=6]Party starts in: " + GameTimer.get_time_text()
