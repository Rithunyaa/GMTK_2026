extends Node2D

@onready var timer_label: RichTextLabel = $CanvasLayer/TimerLabel


func _ready():
	update_timer()
	GameTimer.time_updated.connect(update_timer)
	
	var player := $Player
	match GameTimer.previous_scene:
		"hallway": player.position = Vector2(987, 577)
		"laundry_task": player.position = Vector2(329,425)
		
		"kitchen": player.position = Vector2(987, 577)
	
	GameTimer.previous_scene = 'bedroom'


func update_timer():
	timer_label.text = "[shake level=6]Party starts in: " + GameTimer.get_time_text()
