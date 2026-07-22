extends Node2D


var player_health = 100
var enemy_health = 100


func player_attack():
	enemy_health -= 20
	print("Enemy HP:", enemy_health)

	if enemy_health <= 0:
		print("YOU WIN")


func enemy_attack():
	player_health -= 10
	print("Player HP:", player_health)

	if player_health <= 0:
		print("YOU LOSE")


func _on_attack_button_pressed():
	player_attack()
	enemy_attack()
