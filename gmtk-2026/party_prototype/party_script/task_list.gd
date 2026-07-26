extends RichTextLabel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# update task list every frame might not be a good idea
	
	var gt = GameTimer
	text = \
	'To-dos: (highlighted in white) \n'+ \
		('	* Collect clothes into laundry basket (bedroom) \n' if not gt.laundry_done else '')+ \
		('	* Filled bowl with chips in kitchen \n' if not gt.chips_done else '')+ \
		('	* Inflate balloons in living room \n' if not gt.balloons_done else '')+ \
		('	* Tidy up banners in living room \n' if not gt.banners_done else '')+ \
	'WASD/Arrow keys to move,E to interact'
	
	visible = not GameTimer.show_intro
