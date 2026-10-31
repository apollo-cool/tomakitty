extends Node2D
class_name Food

signal food_eaten(food: Food)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event is InputEventMouseButton):
		food_eaten.emit(self)
