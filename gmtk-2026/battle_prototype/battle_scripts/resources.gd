extends Area2D


@export var item_type = "attack"


func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.name == "Player":
		body.inventory[item_type] += 1
		print(body.inventory)

		queue_free()
