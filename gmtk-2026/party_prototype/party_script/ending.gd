extends Control

@onready var label: RichTextLabel = $Text

func _on_playagain_button_pressed() -> void:
	call_deferred("_change_scene")
	
func _change_scene():
	get_tree().change_scene_to_file("res://party_prototype/party_scenes/Bedroom.tscn")

func _ready():

	if GameTimer.laundry_done \
	and GameTimer.chips_done \
	and GameTimer.balloons_done \
	and GameTimer.banners_done:

		label.text = "[wave]You got ready in time!"

	else:

		label.text = "[wave]The party started before you were ready..."
