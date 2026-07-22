extends Area2D


func _on_area_entered(area):
	print("Clothing collected!")
	area.collected.emit()
	area.queue_free()
