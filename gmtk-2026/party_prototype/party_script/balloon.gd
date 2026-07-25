extends Node2D
signal balloon_completed

@onready var balloon = $Balloon
#@onready var green_zone = $GreenZone
@onready var circle = $Circle

var balloon_size = 0.5
var growth_speed = 1
var growing = true

var good_min_size = 1.5
var good_max_size = 2.0

var max_size = 2.5
var min_size = 0.5

var can_click = false


var balloons_completed = 0
var balloons_needed = 1
var completed = false



func _ready():
	#green_zone.visible = false
	circle.frame = 0



func _process(delta):

	# Stop this balloon completely once finished
	if completed:
		return


	if growing:
		balloon_size += growth_speed * delta

		if balloon_size >= max_size:
			growing = false

	else:
		balloon_size -= growth_speed * delta

		if balloon_size <= min_size:
			growing = true


	balloon.scale = Vector2(
		balloon_size*8,
		balloon_size*8
	)


	# Check if balloon is in the green zone
	if balloon_size >= good_min_size and balloon_size <= good_max_size:
		can_click = true
		#green_zone.visible = true
		circle.frame = 1

	else:
		can_click = false
		#green_zone.visible = false
		circle.frame = 0



func _input(event):

	if completed:
		return

	if event is InputEventMouseButton:
		
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:

			if can_click:
				success()

			else:
				fail()



func success():

	print("Balloons Finished")

	completed = true

	# Freeze balloon at its successful size
	set_process(false)

	can_click = false

	#green_zone.visible = false
	circle.frame = 1

	# Tell the main level this balloon is done
	balloon_completed.emit()



func fail():

	print("Missed!")

	# Only reset if this balloon is not completed
	if not completed:
		balloon_size = min_size

		balloon.scale = Vector2(
			balloon_size*8,
			balloon_size*8
		)

		#green_zone.visible = false
		circle.frame = 0
