extends Node2D


var selected_banner = null
var current_line: Line2D
var right_banners = []
var banners = []
var completed_connections = 0
@onready var timer_label: RichTextLabel = $CanvasLayer/TimerLabel


func _ready():

	for banner in $Banners.get_children():

		banners.append(banner)

		banner.input_event.connect(
			func(viewport, event, shape):
				_on_banner_clicked(banner, event)
		)

	randomize_banners()
	update_timer()
	GameTimer.time_updated.connect(update_timer)
	
	GameTimer.previous_scene = "chips_task"


func _process(delta):

	if current_line:
		current_line.set_point_position(
			1,
			get_global_mouse_position()
		)


func _on_banner_clicked(banner, event):

	if event is InputEventMouseButton:

		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:

			# First click
			if selected_banner == null and not banner.connected:

				selected_banner = banner
				create_line(banner)

			# Second click
			else:

				finish_line(banner)


func create_line(banner):

	current_line = Line2D.new()

	current_line.width = 8
	current_line.default_color = Color.WHITE

	$Lines.add_child(current_line)

	current_line.add_point(
		banner.global_position
	)

	current_line.add_point(
		get_global_mouse_position()
	)
	
func finish_line(banner):

	if current_line:

		if banner.banner_color == selected_banner.banner_color:

			current_line.set_point_position(
				1,
				banner.global_position
			)

			selected_banner.lock()
			banner.lock()

			completed_connections += 1

			current_line = null
			selected_banner = null

			print("Correct!")

			if completed_connections >= 4:
				finish_task()

		else:

			# Wrong connection
			current_line.queue_free()

			current_line = null
			selected_banner = null

			print("Wrong!")
			
func randomize_right_banners():

	var colors = [
		"red",
		"blue",
		"green",
		"yellow"
	]

	colors.shuffle()

	for i in range(right_banners.size()):
		right_banners[i].banner_color = colors[i]
		right_banners[i].update_texture()

func randomize_banners():

	var colors = [
		"red",
		"blue",
		"purple",
		"pink"
	]

	var left_colors = colors.duplicate()
	var right_colors = colors.duplicate()

	left_colors.shuffle()
	right_colors.shuffle()


	var left_index = 0
	var right_index = 0


	for banner in banners:

		if banner.position.x < 600:
			banner.banner_color = left_colors[left_index]
			left_index += 1

		else:
			banner.banner_color = right_colors[right_index]
			right_index += 1

		banner.update_texture()
		
func finish_task():

	print("Banners finished!")
	GameTimer.banners_done = true

	get_tree().change_scene_to_file(
		"res://party_prototype/party_scenes/living_room.tscn"
	)

func update_timer():
	timer_label.text = "[shake level=6]Party starts in: " + GameTimer.get_time_text()
