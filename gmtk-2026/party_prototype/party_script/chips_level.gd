extends Node2D


@export var chip_scene: PackedScene

@onready var red_line: Sprite2D = $RedLine
@onready var fill_line: Line2D = $FillLine
@onready var bowl_area: Area2D = $Bowl/BowlArea


var fill_amount = 0
var max_fill = 100
var finished = false


func _ready():
	bowl_area.area_entered.connect(_on_chip_entered)


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			
			var mouse_position = get_global_mouse_position()

			if mouse_position.y < $RedLine.global_position.y:
				spawn_chip(mouse_position)


func spawn_chip(click_position):
	var chip = chip_scene.instantiate()

	add_child(chip)

	chip.global_position = click_position



		
func check_finished():
	if finished:
		return

	if fill_line.global_position.y <= 640:
		finished = true
		print("Task Complete!")
		call_deferred("go_to_kitchen")
		
func go_to_kitchen():
	call_deferred("_change_scene")
	

func _on_chip_entered(area):
	if area.name == "Chip":
		fill_line.position.y -= 10
		
		area.call_deferred("queue_free")

		check_finished()

func _change_scene():
	get_tree().change_scene_to_file("res://party_prototype/party_scenes/kitchen.tscn")
