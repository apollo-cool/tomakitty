extends Node2D
class_name Bed
signal tomakitty_slept

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event is InputEventMouseButton):
		tomakitty_slept.emit(self)
