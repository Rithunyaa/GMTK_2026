extends Node2D

@onready var timer_label: RichTextLabel = $CanvasLayer/TimerLabel
@onready var instruction: RichTextLabel = $CanvasLayer/Instructions


func _ready():

	update_timer()
	GameTimer.time_updated.connect(update_timer)

	var player := $Player

	match GameTimer.previous_scene:

		"kitchen":
			player.position = Vector2(1100,523)

			instruction.text = "Head right (into the living room)"

		"living_room":
			player.position = Vector2(95,332)

		_:
			instruction.text = "Head into the first room on the bottom."


	GameTimer.previous_scene = "hallway"

func update_timer():
	timer_label.text = "[shake level=6]Party starts in: " + GameTimer.get_time_text()
