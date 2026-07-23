extends Area2D

@onready var animation = $AnimationPlayer

func _on_area_entered(area):
	print("Clothing collected!")
	animation.play("clothes_collected")
	area.collected.emit()
	area.queue_free()
