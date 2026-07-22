extends Node2D

@onready var timer_label: Label = $CanvasLayer/Timer
@onready var countdown_timer: Timer = $CountDownTimer


var time_left = 60


func _ready():
	update_timer_text()


func _process(_delta):
	time_left = countdown_timer.time_left
	update_timer_text()


func update_timer_text():
	timer_label.text = "TIME: " + str(ceil(time_left))

func _on_count_down_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://battle_prototype/battle_scenes/fight_battle.tscn")
	print ("fight started")
