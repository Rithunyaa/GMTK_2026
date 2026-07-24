extends Area2D


var velocity = Vector2.ZERO
var chip_gravity = 500

@onready var sprite = $Sprite2D


var chip_variations = [
	preload("res://party_prototype/party_assets/chip_1.png"),
	preload("res://party_prototype/party_assets/chip_2.png"),
	preload("res://party_prototype/party_assets/chip_3.png")
]


func _ready():
	sprite.texture = chip_variations.pick_random()
	area_entered.connect(_on_area_entered)


func _physics_process(delta):
	velocity.y += chip_gravity * delta
	
	position += velocity * delta


func _on_area_entered(area):
	if area.name == "BowlArea":
		var level = get_parent()

		level.fill_line.position.y -= 10

		queue_free()
