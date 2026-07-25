extends Node2D


@onready var balloon = $Balloon
@onready var green_zone = $GreenZone


var balloon_size = 0.5
var growth_speed = 1
var growing = true



var good_min_size = 1.5
var good_max_size = 2.0

var max_size = 2.5
var min_size = 0.5

var can_click = false


var balloons_completed = 0
var balloons_needed = 3



func _ready():
	green_zone.visible = false




func _process(delta):

	if growing:
		balloon_size += growth_speed * delta

		if balloon_size >= max_size:
			growing = false

	else:
		balloon_size -= growth_speed * delta

		if balloon_size <= min_size:
			growing = true


	balloon.scale = Vector2(
		balloon_size,
		balloon_size
	)


	# Check green zone
	if balloon_size >= good_min_size and balloon_size <= good_max_size:
		can_click = true
		green_zone.visible = true

	else:
		can_click = false
		green_zone.visible = false


	if balloon_size >= good_min_size and balloon_size <= good_max_size:
	
		can_click = true
		green_zone.visible = true

	else:
	
		can_click = false
		green_zone.visible = false



func _input(event):

	if event is InputEventMouseButton:
		
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:

			if can_click:
				success()

			else:
				fail()



func success():

	print("Good!")

	balloons_completed += 1


	if balloons_completed >= balloons_needed:
		finish_task()

	else:
		reset_balloon()



func fail():

	print("Missed!")

	reset_balloon()



func reset_balloon():

	balloon_size = 0.2

	balloon.scale = Vector2(
		balloon_size,
		balloon_size
	)

	green_zone.visible = false





func finish_task():

	print("Balloons finished!")

	get_tree().change_scene_to_file(
		"res://party_prototype/party_scenes/Bedroom.tscn"
	)
