extends Area2D


@export var item_type = "attack"


func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.name == "Player":

		if item_type == "attack":
			GameManager.attack_cards += 1

		elif item_type == "health":
			GameManager.health_potions += 1

		elif item_type == "shield":
			GameManager.shields += 1

		print(GameManager.attack_cards)
		print(GameManager.health_potions)
		print(GameManager.shields)

		queue_free()
