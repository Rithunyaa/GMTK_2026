extends Node2D

var player_health = 100
var enemy_health = 100

var player_damage = 20

var enemy_attacks = [10, 15, 25]

var heal_amount = 25
var shield_active = false

var heals_left
var shields_left

@onready var heal_label: Label = $CanvasLayer/HealCountLabel
@onready var shield_label: Label = $CanvasLayer/ShieldCountLabel



func player_attack():
	enemy_health -= player_damage
	print("Enemy HP:", enemy_health)

	if enemy_health <= 0:
		print("YOU WIN")
		return

	enemy_turn()


func enemy_turn():

	var damage = enemy_attacks.pick_random()

	if shield_active:
		damage = 0
		shield_active = false
		print("Shield blocked the attack!")

	player_health -= damage

	print("Enemy dealt:", damage)
	print("Player HP:", player_health)

	if player_health <= 0:
		print("YOU LOSE")


func _on_attack_button_pressed():
	player_attack()
	
	
func heal():

	if heals_left <= 0:
		print("No heals left!")
		return

	heals_left -= 1
	update_items()

	player_health += heal_amount

	if player_health > 100:
		player_health = 100

	print("Healed!")
	print("Heals remaining:", heals_left)
	print("Player HP:", player_health)

	enemy_turn()
	
func shield():

	if shields_left <= 0:
		print("No shields left!")
		return

	shields_left -= 1
	update_items()

	shield_active = true

	print("Shield activated!")
	print("Shields remaining:", shields_left)

	enemy_turn()


func _on_heal_button_pressed() -> void:
	heal()


func _on_shield_button_pressed() -> void:
	shield()
	
func update_items():

	heal_label.text = "Heal: " + str(heals_left)

	shield_label.text = "Shield: " + str(shields_left)

func _ready():

	heals_left = GameManager.health_potions
	shields_left = GameManager.shields

	update_items()
