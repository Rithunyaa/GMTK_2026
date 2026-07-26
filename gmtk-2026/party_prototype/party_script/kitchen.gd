extends Node2D

@onready var timer_label: RichTextLabel = $CanvasLayer/TimerLabel
@onready var instruction_text: RichTextLabel = $CanvasLayer/Instructions


func _ready():

	update_timer()
	GameTimer.time_updated.connect(update_timer)

	var player := $Player

	match GameTimer.previous_scene:

		"chips_task":
			player.position = Vector2(805,392)

			# Came back after completing chips
			#instruction_text.text = "Head into the hallway"
			#instruction_text.visible = true
#
#
		#_:
			# First time entering kitchen
			#instruction_text.text = "Click the bowl (highlighted white)"
			#instruction_text.visible = true


	GameTimer.previous_scene = "kitchen"


func update_timer():
	timer_label.text = "[shake level=6]Party starts in: " + GameTimer.get_time_text()
