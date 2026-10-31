extends Node2D

signal food_eaten

func _on_area_2d_input_event(_viewport: Node, event: InputEvent) -> void:
	if (event is InputEventMouseButton):
		food_eaten.emit()
