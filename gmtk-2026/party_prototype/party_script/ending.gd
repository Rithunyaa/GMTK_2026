extends Control

@onready var label: RichTextLabel = $Text
@onready var playagain_button: Button = $playagain_button

func _on_playagain_button_pressed() -> void:
	call_deferred("_change_scene")
	
func _change_scene():
	GameTimer.reset_timer()
	GameTimer.show_intro = true
	get_tree().change_scene_to_file("res://party_prototype/party_scenes/Bedroom.tscn")

func _ready():

	if GameTimer.laundry_done \
	and GameTimer.chips_done \
	and GameTimer.balloons_done \
	and GameTimer.banners_done:

		label.text = "[wave]You got ready in time!
The time you used: " + str(int(GameTimer.time_used)) + "s"
		playagain_button.text = "Play Again"

	else:

		label.text = "[wave]The party started before you were ready..."
		playagain_button.text = "Try Again"
