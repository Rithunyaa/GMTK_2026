extends Node2D

@export var clothing_type_1: PackedScene
@export var clothing_type_2: PackedScene
@export var amount_of_clothes = 5
var time_left = 30

@onready var timer_label = $CanvasLayer/TimerLabel
@onready var counter: Label = $CanvasLayer/ClothesCounter

var cleaned_clothes = 0
var spawn_area = Rect2(100, 100, 950, 450)


func _ready():
	spawn_clothes()
	update_counter()


func spawn_clothes():
	var clothes_to_spawn = []

	# Figure out who gets the extra clothing
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

	# Randomize their order
	clothes_to_spawn.shuffle()

	# Spawn them
	for clothing_scene in clothes_to_spawn:
		var clothing = clothing_scene.instantiate()

		var random_position = Vector2(
			randf_range(spawn_area.position.x, spawn_area.end.x),
			randf_range(spawn_area.position.y, spawn_area.end.y)
		)

		clothing.position = random_position
		clothing.collected.connect(clothing_collected)
		add_child(clothing)


func clothing_collected():
	cleaned_clothes += 1
	update_counter()

	if cleaned_clothes == amount_of_clothes:
		print("Party ready!")
		get_tree().paused = true

func _on_party_timer_timeout():
	time_left -= 1
	
	timer_label.text = "Party starts in: " + str(time_left)
	
	if time_left <= 0:
		print("You ran out of time!")
		get_tree().paused = true

func update_counter():
	counter.text = "Clothes Cleaned: " + str(cleaned_clothes) + "/" + str(amount_of_clothes)
