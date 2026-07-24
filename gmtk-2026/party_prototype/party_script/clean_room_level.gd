extends Node2D

@export var clothing_type_1: PackedScene
@export var clothing_type_2: PackedScene
@export var amount_of_clothes = 5

@onready var timer_label = $CanvasLayer/TimerLabel
@onready var laundry_basket: Area2D = $LaundryBasket
@onready var laundry_drop_sound = $LaundryDropSound

var cleaned_clothes = 0
var spawn_area = Rect2(100, 100, 950, 450)
var spawned_positions = []


func _ready():
	spawn_clothes()
	update_timer()

	GameTimer.time_updated.connect(update_timer)
	GameTimer.time_finished.connect(go_to_bedroom)


func spawn_clothes():
	laundry_basket.monitoring = false
	
	var clothes_to_spawn = []

	# Decide clothing split
	if randi() % 2 == 0:
		for i in range(3):
			clothes_to_spawn.append(clothing_type_1)

		for i in range(2):
			clothes_to_spawn.append(clothing_type_2)

	else:
		for i in range(2):
			clothes_to_spawn.append(clothing_type_1)

		for i in range(3):
			clothes_to_spawn.append(clothing_type_2)


	# Randomize order
	clothes_to_spawn.shuffle()


	# Spawn clothes
	for clothing_scene in clothes_to_spawn:
		var clothing = clothing_scene.instantiate()

		clothing.position = get_safe_spawn_position()

		clothing.collected.connect(clothing_collected)

		spawned_positions.append(clothing.position)

		add_child(clothing)


	laundry_basket.monitoring = true



func clothing_collected():
	laundry_drop_sound.play()

	cleaned_clothes += 1

	if cleaned_clothes == amount_of_clothes:
		print("Laundry finished!")
		go_to_bedroom()



func get_safe_spawn_position():
	var position = Vector2.ZERO
	
	while true:
		position = Vector2(
			randf_range(spawn_area.position.x, spawn_area.end.x),
			randf_range(spawn_area.position.y, spawn_area.end.y)
		)

		var basket_distance = position.distance_to(laundry_basket.position)

		var too_close_to_clothes = false

		for old_position in spawned_positions:
			if position.distance_to(old_position) < 100:
				too_close_to_clothes = true
				break


		if basket_distance > 300 and not too_close_to_clothes:
			return position



func update_timer():
	timer_label.text = "Party starts in: " + GameTimer.get_time_text()



func go_to_bedroom():
	call_deferred("_change_to_bedroom")


func _change_to_bedroom():
	await $DarkScreen.darker()
	get_tree().change_scene_to_file("res://party_prototype/party_scenes/Bedroom.tscn")
