extends Node2D


@onready var timer_label: RichTextLabel = $CanvasLayer/TimerLabel

@onready var dialogue_box := $CanvasLayer/ColorRect
@onready var dialogue_text: RichTextLabel = $CanvasLayer/RichTextLabel


var dialogue_message = "The party is starting soon! We need to finish everything before the timer runs out!
(click anywhere to start)
"

var typing = false
var waiting_to_close = false

var letter_index = 0
var typing_speed = 0.01

var auto_timer = 0.0
var auto_start_time = 5.0


func _ready():

	update_timer()
	GameTimer.time_updated.connect(update_timer)
	


	# Spawn player correctly
	var player := $Player

	match GameTimer.previous_scene:

		"hallway":
			player.position = Vector2(987, 577)

		"laundry_task":
			player.position = Vector2(329,425)
			dialogue_text.text = "Leave the bedroom (door is below yellow rug)"

		"kitchen":
			player.position = Vector2(987, 577)
		
		"main_menu":
			start_intro()
		
		
	# still we need GameTimer.show_intro
	# mayber passing "main_menu" via previous_scene is a bad idea
	if not GameTimer.show_intro:
			start_game()


	GameTimer.previous_scene = "bedroom"


	# Intro check
	#if GameTimer.show_intro:
#
		#start_intro()
#
	#else:

#		start_game()



func start_intro():
	$Player.can_move = false
	
	GameTimer.game_active = false

	dialogue_box.visible = true
	dialogue_text.visible = true

	dialogue_text.text = ""

	typing = true
	waiting_to_close = false

	letter_index = 0



func _process(delta):

	if typing:

		type_text()


	elif waiting_to_close:

		auto_timer += delta

		if auto_timer >= auto_start_time:

			close_intro()



func type_text():

	if letter_index < dialogue_message.length():

		dialogue_text.text += dialogue_message[letter_index]

		letter_index += 1

		await get_tree().create_timer(typing_speed).timeout


	else:

		typing = false
		waiting_to_close = true
		auto_timer = 0



func _input(event):

	if event is InputEventMouseButton:

		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:


			if typing:

				finish_text()


			elif waiting_to_close:

				close_intro()



func finish_text():

	dialogue_text.text = dialogue_message

	typing = false
	waiting_to_close = true
	auto_timer = 0



func close_intro():
	$Player.can_move = true

	dialogue_box.visible = false
	dialogue_text.visible = false

	GameTimer.show_intro = false
	waiting_to_close = false

	start_game()
	GameTimer.reset_timer()



func start_game():

	GameTimer.game_active = true
	dialogue_text.add_theme_constant_override("outline_size", 30)
	dialogue_text.visible = true
	
	dialogue_text.text = "Click the laundry basket (highlighted white)"

	#it is a bug,timer shouldnt be reset everytime whenever player enter
	#GameTimer.reset_timer()



func update_timer():

	timer_label.text = "[shake level=6]Party starts in: " + GameTimer.get_time_text()
