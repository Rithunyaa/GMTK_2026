extends Area2D


func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.name == "Player":
		set_deferred("monitoring", false)
		call_deferred("_go_to_bedroom")


func _go_to_bedroom():
	await get_parent().get_node("DarkScreen").darker()
	get_tree().change_scene_to_file("res://party_prototype/party_scenes/Bedroom.tscn")
