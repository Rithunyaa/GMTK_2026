extends Node2D

@onready var timer_label: RichTextLabel = $CanvasLayer/TimerLabel


func _ready():
	update_timer()
	GameTimer.time_updated.connect(update_timer)


func update_timer():
	timer_label.text = "[shake level=10]Party starts in: " + GameTimer.get_time_text()
