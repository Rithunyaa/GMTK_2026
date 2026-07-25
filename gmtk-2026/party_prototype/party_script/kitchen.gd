extends Node2D

@onready var timer_label: RichTextLabel = $CanvasLayer/TimerLabel


func _ready():
	update_timer()
	GameTimer.time_updated.connect(update_timer)
	
	var player := $Player
	
	match GameManager.previous_scene:
		"chips_task": player.position = Vector2(805,392)
	
	GameManager.previous_scene = "kitchen"


func update_timer():
	timer_label.text = "[shake level=6]Party starts in: " + GameTimer.get_time_text()
